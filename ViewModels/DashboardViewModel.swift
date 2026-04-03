import Foundation
import SwiftUI
import MapKit
import UIKit

// MARK: - Haptic Feedback Manager
final class HapticManager {
    static let shared = HapticManager()
    private init() {}
    
    func selection() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
    
    func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
    
    func success() {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.success)
    }
    
    func warning() {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.warning)
    }
    
    func error() {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.error)
    }
    
    func heavyImpact() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred(intensity: 1.0)
    }
}

enum CancellationReason: String, CaseIterable, Identifiable {
    case driverFar = "Driver is too far"
    case changedPlans = "Changed my plans"
    case foundAnother = "Found another ride"
    case wrongPickup = "Wrong pickup location"
    case priceTooHigh = "Price is too high"
    case longWait = "Long wait time"
    case other = "Other reason"
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .driverFar: return "car.side.front.open"
        case .changedPlans: return "arrow.uturn.left.circle"
        case .foundAnother: return "hand.thumbsup"
        case .wrongPickup: return "mappin.slash"
        case .priceTooHigh: return "indianrupeesign.arrow.circlepath"
        case .longWait: return "clock.badge.exclamationmark"
        case .other: return "ellipsis.circle"
        }
    }
}

enum BookingState: Equatable {
    case idle
    case enteringLocations
    case routePreview
    case comparingFares
    case findingCaptain
    case rideConfirmed
}

struct NearbyDriver: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let vehicleType: VehicleType
}

@MainActor
class DashboardViewModel: ObservableObject {
    @Published var bookingState: BookingState = .idle
    @Published var recentTrips: [Ride] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    @Published var assignedDriver: Driver?
    @Published var otp: String = ""
    @Published var selectedDestination: String = ""
    @Published var selectedPickup: String = "Current Location"
    @Published var selectedVehicle: VehicleType?
    
    // Surge Pricing
    @Published var isSurgeActive = false
    @Published var surgeMultiplier: Double = 1.0
    
    // Promo Code
    @Published var appliedPromoCode: String?
    @Published var promoDiscount: Int = 0
    
    // Coordinates
    @Published var pickupCoordinate = CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946)
    @Published var dropCoordinate = CLLocationCoordinate2D(latitude: 12.9784, longitude: 77.6408)
    @Published var routeDistance: Double = 0 // in km
    @Published var routeETA: Int = 0 // in minutes
    
    @Published var nearbyDrivers: [NearbyDriver] = []
    @Published var driverLocation: CLLocationCoordinate2D?
    private var driverTimer: Timer?
    
    // Dynamic fares based on distance and surge/promo
    var bikeFare: Int { calculateFare(base: 12, minFare: 25) }
    var autoFare: Int { calculateFare(base: 18, minFare: 35) }
    var cabFare: Int { calculateFare(base: 35, minFare: 80) }
    
    private func calculateFare(base: Double, minFare: Int) -> Int {
        let baseAmount = Double(max(minFare, Int(routeDistance * base)))
        let surgedAmount = baseAmount * (isSurgeActive ? surgeMultiplier : 1.0)
        return max(0, Int(surgedAmount) - promoDiscount)
    }
    
    var fareEstimates: [VehicleType: Int] {
        [.bike: bikeFare, .auto: autoFare, .cab: cabFare, .parcel: calculateFare(base: 15, minFare: 40)]
    }
    var fareETAs: [VehicleType: String] {
        [.bike: "\(max(2, Int(routeDistance * 2))) min", .auto: "\(max(3, Int(routeDistance * 2.5))) min", .cab: "\(max(5, Int(routeDistance * 3))) min", .parcel: "\(max(8, Int(routeDistance * 4))) min"]
    }
    
    let popularDestinations: [PopularPlace] = [
        PopularPlace(name: "Indiranagar Metro", address: "100 Feet Rd, Indiranagar", icon: "tram.fill"),
        PopularPlace(name: "Koramangala 5th Block", address: "80 Feet Rd, Koramangala", icon: "building.2.fill"),
        PopularPlace(name: "MG Road", address: "MG Road, Bangalore", icon: "cart.fill"),
        PopularPlace(name: "Kempegowda Airport", address: "KIAL, Devanahalli", icon: "airplane"),
        PopularPlace(name: "Whitefield ITPL", address: "ITPL Main Road", icon: "laptopcomputer"),
        PopularPlace(name: "Electronic City", address: "Phase 1, EC", icon: "cpu"),
    ]
    
    private let dashboardService = DashboardService()
    
    init() {
        generateNearbyDrivers()
        Task { await fetchRides() }
        
        // Randomly activate surge for demo
        if Double.random(in: 0...1) > 0.7 {
            isSurgeActive = true
            surgeMultiplier = Double.random(in: 1.2...1.8)
        }
    }
    
    func generateNearbyDrivers() {
        let center = pickupCoordinate
        var drivers: [NearbyDriver] = []
        let types: [VehicleType] = [.bike, .bike, .bike, .auto, .auto, .cab, .bike, .auto, .cab, .bike]
        
        for type in types {
            drivers.append(NearbyDriver(
                coordinate: CLLocationCoordinate2D(
                    latitude: center.latitude + Double.random(in: -0.012...0.012),
                    longitude: center.longitude + Double.random(in: -0.012...0.012)
                ),
                vehicleType: type
            ))
        }
        nearbyDrivers = drivers
    }
    
    func fetchRides() async {
        isLoading = true
        errorMessage = nil
        do {
            let rides = try await dashboardService.fetchRides()
            self.recentTrips = rides.filter { $0.status == .completed }
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    // MARK: - New Location Flow
    func openLocationSearch() {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.9)) {
            bookingState = .enteringLocations
        }
    }
    
    func confirmLocations(pickupName: String, dropName: String, dropCoordinate: CLLocationCoordinate2D) {
        self.selectedPickup = pickupName
        self.selectedDestination = dropName
        self.dropCoordinate = dropCoordinate
        
        // Calculate distance
        let pickupLoc = CLLocation(latitude: pickupCoordinate.latitude, longitude: pickupCoordinate.longitude)
        let dropLoc = CLLocation(latitude: dropCoordinate.latitude, longitude: dropCoordinate.longitude)
        let distanceMeters = pickupLoc.distance(from: dropLoc)
        routeDistance = distanceMeters / 1000.0
        routeETA = max(5, Int(routeDistance * 2.5))
        
        withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
            bookingState = .routePreview
        }
    }
    
    func proceedToFares() {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
            bookingState = .comparingFares
        }
    }
    
    func applyPromo(code: String, discount: Int) {
        self.appliedPromoCode = code
        self.promoDiscount = discount
        HapticManager.shared.success()
    }
    
    func removePromo() {
        self.appliedPromoCode = nil
        self.promoDiscount = 0
        HapticManager.shared.selection()
    }
    
    func bookRide(vehicle: VehicleType) {
        self.selectedVehicle = vehicle
        withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
            bookingState = .findingCaptain
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.simulateDriverFound(for: vehicle)
        }
    }
    
    private func simulateDriverFound(for vehicle: VehicleType) {
        let names = ["Ramesh Babu", "Suresh Kumar", "Vikram Singh", "Arjun Reddy", "Mohan Das", "Kiran M", "Naveen S", "Prakash R"]
        let vehicles: [String] = vehicle == .bike ? ["Honda Activa 6G", "TVS Jupiter", "Ola S1 Pro", "Ather 450X"] : (vehicle == .auto ? ["Bajaj RE", "Piaggio Ape", "TVS King"] : ["Maruti Dzire", "Hyundai Aura", "Toyota Etios", "Tata Tigor"])
        
        self.assignedDriver = Driver(
            id: UUID().uuidString,
            name: names.randomElement()!,
            rating: Double(Int.random(in: 42...49)) / 10.0,
            vehicleModel: vehicles.randomElement()!,
            plateNumber: "KA 0\(Int.random(in: 1...5)) \(["AB", "CD", "EF", "MN", "XY"].randomElement()!) \(Int.random(in: 1000...9999))",
            phoneNumber: "+91 \(Int.random(in: 7000000000...9999999999))",
            vehicleType: vehicle
        )
        self.otp = String(format: "%04d", Int.random(in: 1000...9999))
        
        driverLocation = CLLocationCoordinate2D(
            latitude: pickupCoordinate.latitude + Double.random(in: -0.008...0.008),
            longitude: pickupCoordinate.longitude + Double.random(in: -0.008...0.008)
        )
        startDriverMovement(toward: pickupCoordinate)
        
        withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
            self.bookingState = .rideConfirmed
        }
    }
    
    private func startDriverMovement(toward target: CLLocationCoordinate2D) {
        driverTimer?.invalidate()
        driverTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            guard let self = self, let current = self.driverLocation else { return }
            let newLat = current.latitude + (target.latitude - current.latitude) * 0.12
            let newLng = current.longitude + (target.longitude - current.longitude) * 0.12
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 1.8)) {
                    self.driverLocation = CLLocationCoordinate2D(latitude: newLat, longitude: newLng)
                }
            }
        }
    }
    
    func cancelBooking(reason: CancellationReason? = nil) {
        // Log reason if provided for analytics
        if let reason = reason {
            print("Ride cancelled with reason: \(reason.rawValue)")
        }
        
        driverTimer?.invalidate()
        driverTimer = nil
        withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
            self.bookingState = .idle
            self.selectedDestination = ""
            self.selectedPickup = "Current Location"
            self.selectedVehicle = nil
            self.assignedDriver = nil
            self.otp = ""
            self.driverLocation = nil
            self.routeDistance = 0
            self.routeETA = 0
            self.appliedPromoCode = nil
            self.promoDiscount = 0
        }
        generateNearbyDrivers()
    }
}


struct PopularPlace: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let icon: String
}
