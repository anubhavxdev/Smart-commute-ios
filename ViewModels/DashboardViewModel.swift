import Foundation
import SwiftUI

enum BookingState {
    case idle
    case comparingFares
    case findingCaptain
    case rideConfirmed
}

@MainActor
class DashboardViewModel: ObservableObject {
    @Published var bookingState: BookingState = .idle
    @Published var upcomingRide: Ride?
    @Published var recentTrips: [Ride] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Booking specific simulated data
    @Published var assignedDriver: Driver?
    @Published var otp: String = ""
    @Published var selectedDestination: String = ""
    @Published var selectedVehicle: VehicleType?
    
    // Mock Fares
    let fareEstimates: [VehicleType: Int] = [.bike: 45, .auto: 80, .cab: 250, .parcel: 60]
    
    private let dashboardService = DashboardService()
    
    init() {
        Task {
            await fetchRides()
        }
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
    
    // Simulate flow
    func startBooking(destination: String) {
        self.selectedDestination = destination.isEmpty ? "Indiranagar Metro Station" : destination
        withAnimation {
            bookingState = .comparingFares
        }
    }
    
    func bookRide(vehicle: VehicleType) {
        self.selectedVehicle = vehicle
        withAnimation {
            bookingState = .findingCaptain
        }
        
        // Simulate waiting for matching algorithm
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.simulateDriverFound(for: vehicle)
        }
    }
    
    private func simulateDriverFound(for vehicle: VehicleType) {
        self.assignedDriver = Driver(
            id: UUID().uuidString,
            name: "Ramesh Babu",
            rating: 4.8,
            vehicleModel: vehicle == .bike ? "Honda Activa 6G" : (vehicle == .auto ? "Bajaj RE" : "Maruti Dzire"),
            plateNumber: "KA 01 AB 1234",
            phoneNumber: "+91 9876543210",
            vehicleType: vehicle
        )
        self.otp = String(format: "%04d", Int.random(in: 1000...9999))
        
        withAnimation {
            self.bookingState = .rideConfirmed
        }
    }
    
    func cancelBooking() {
        withAnimation {
            self.bookingState = .idle
            self.selectedDestination = ""
            self.selectedVehicle = nil
            self.assignedDriver = nil
            self.otp = ""
        }
    }
}
