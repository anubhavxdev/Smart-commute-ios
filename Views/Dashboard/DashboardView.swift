import SwiftUI
import MapKit

struct DashboardView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var viewModel = DashboardViewModel()
    
    @State private var showMenu = false
    @State private var navigateTo: AppDestination?
    @State private var showRating = false
    @State private var showNavigation = false
    
    let brandYellow = Color(red: 0.98, green: 0.79, blue: 0.21)
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Map
                RouteMapView(
                    pickupCoordinate: viewModel.pickupCoordinate,
                    dropCoordinate: viewModel.dropCoordinate,
                    driverLocation: viewModel.driverLocation,
                    nearbyDrivers: viewModel.nearbyDrivers,
                    showRoute: viewModel.bookingState == .routePreview || viewModel.bookingState == .comparingFares || viewModel.bookingState == .findingCaptain,
                    bookingState: viewModel.bookingState
                )
                .ignoresSafeArea()
                
                // Center pin for idle
                if viewModel.bookingState == .idle {
                    VStack {
                        Spacer().frame(height: UIScreen.main.bounds.height * 0.32)
                        Image(systemName: "mappin.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.red)
                            .shadow(radius: 3)
                        Spacer()
                    }
                }
                
                // Overlay UI
                VStack(spacing: 0) {
                    // Top bar (hidden during location search)
                    if viewModel.bookingState != .enteringLocations {
                        topBar
                    }
                    
                    Spacer()
                    
                    // Bottom sheets
                    Group {
                        switch viewModel.bookingState {
                        case .idle:
                            idleSheet
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                        case .enteringLocations:
                            EmptyView() // Full screen handled separately
                        case .routePreview:
                            routePreviewSheet
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                        case .comparingFares:
                            VehicleSelectionSheet(viewModel: viewModel)
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                        case .findingCaptain:
                            FindingCaptainSheet(viewModel: viewModel)
                                .transition(.asymmetric(
                                    insertion: .scale(scale: 0.8).combined(with: .opacity),
                                    removal: .scale(scale: 0.8).combined(with: .opacity)
                                ))
                        case .rideConfirmed:
                            ActiveRideSheet(viewModel: viewModel, onEndRide: {
                                showRating = true
                            })
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                        }
                    }
                }
                .ignoresSafeArea(edges: .bottom)
                
                // Full-screen location search
                if viewModel.bookingState == .enteringLocations {
                    LocationSearchView(viewModel: viewModel)
                        .transition(.move(edge: .bottom))
                        .ignoresSafeArea(.keyboard)
                }
                
                // Side Menu
                if showMenu {
                    SideMenuView(isShowing: $showMenu, navigateTo: $navigateTo)
                        .environmentObject(authViewModel)
                        .transition(.opacity)
                        .onDisappear {
                            if navigateTo != nil { showNavigation = true }
                        }
                }
                
                // Rating
                if showRating {
                    RatingView(showRating: $showRating, driverName: viewModel.assignedDriver?.name ?? "Driver") {
                        viewModel.cancelBooking()
                    }
                    .transition(.opacity)
                }
            }
            .animation(.spring(response: 0.45, dampingFraction: 0.85), value: viewModel.bookingState)
            .animation(.easeInOut(duration: 0.25), value: showMenu)
            .animation(.easeInOut(duration: 0.25), value: showRating)
            .navigationDestination(isPresented: $showNavigation) {
                destinationView
            }
        }
    }
    
    // MARK: - Route Preview Sheet
    var routePreviewSheet: some View {
        VStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 40, height: 5)
                .padding(.top, 12)
            
            // Route summary
            HStack(spacing: 14) {
                VStack(spacing: 4) {
                    Circle().fill(Color.green).frame(width: 10, height: 10)
                    ForEach(0..<3, id: \.self) { _ in
                        Circle().fill(Color.gray.opacity(0.3)).frame(width: 2, height: 2)
                    }
                    Circle().fill(Color.red).frame(width: 10, height: 10)
                }
                
                VStack(alignment: .leading, spacing: 14) {
                    VStack(alignment: .leading, spacing: 1) {
                        Text(viewModel.selectedPickup)
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                    VStack(alignment: .leading, spacing: 1) {
                        Text(viewModel.selectedDestination)
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                }
                
                Spacer()
                
                // Distance badge
                VStack(spacing: 4) {
                    Text(String(format: "%.1f km", viewModel.routeDistance))
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("~\(viewModel.routeETA) min")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(12)
                .background(brandYellow.opacity(0.15))
                .cornerRadius(12)
            }
            
            // Quick fare preview
            HStack(spacing: 10) {
                FarePreviewChip(icon: "bicycle", label: "Bike", fare: viewModel.bikeFare)
                FarePreviewChip(icon: "car.2.fill", label: "Auto", fare: viewModel.autoFare)
                FarePreviewChip(icon: "car.fill", label: "Cab", fare: viewModel.cabFare)
            }
            
            // Buttons
            HStack(spacing: 12) {
                Button(action: { viewModel.cancelBooking() }) {
                    Text("Change")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                }
                
                Button(action: { viewModel.proceedToFares() }) {
                    Text("Choose Ride")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(brandYellow)
                        .cornerRadius(12)
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 34)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(color: Color.black.opacity(0.12), radius: 25, x: 0, y: -12)
    }
    
    // MARK: - Top Bar
    var topBar: some View {
        HStack {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.25)) { showMenu = true }
            }) {
                Image(systemName: "line.3.horizontal")
                    .font(.title2).padding(12)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.1), radius: 8)
            }
            .foregroundColor(.black)
            
            Spacer()
            
            if viewModel.bookingState == .idle {
                HStack(spacing: 6) {
                    Circle().fill(Color.green).frame(width: 8, height: 8)
                    Text("\(viewModel.nearbyDrivers.count) rides nearby")
                        .font(.caption).fontWeight(.medium)
                }
                .padding(.horizontal, 14).padding(.vertical, 8)
                .background(.ultraThinMaterial).cornerRadius(20)
                .shadow(color: .black.opacity(0.1), radius: 5)
            }
            
            Spacer()
            
            Button(action: { navigateTo = .offers; showNavigation = true }) {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: "bell.fill")
                        .font(.title3).padding(12)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.1), radius: 8)
                    Circle().fill(Color.red).frame(width: 10, height: 10).offset(x: -2, y: 2)
                }
            }
            .foregroundColor(.black)
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
    
    // MARK: - Destination
    @ViewBuilder
    var destinationView: some View {
        switch navigateTo {
        case .rideHistory: RideHistoryView()
        case .wallet: WalletView()
        case .offers: OffersView()
        case .settings: SettingsView().environmentObject(authViewModel)
        case .none: EmptyView()
        }
    }
    
    // MARK: - Idle Sheet
    var idleSheet: some View {
        VStack(spacing: 18) {
            RoundedRectangle(cornerRadius: 3).fill(Color.gray.opacity(0.3)).frame(width: 40, height: 5).padding(.top, 12)
            
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Good \(greetingTime) 👋").font(.subheadline).foregroundColor(.gray)
                    Text("Where to?").font(.title).fontWeight(.black)
                }
                Spacer()
            }
            
            // Search bar → opens location search
            Button(action: { viewModel.openLocationSearch() }) {
                HStack(spacing: 12) {
                    Circle().fill(Color.green).frame(width: 10, height: 10)
                    Text("Enter pickup & destination").foregroundColor(.gray)
                    Spacer()
                    Image(systemName: "magnifyingglass").foregroundColor(.black).padding(8).background(brandYellow).clipShape(Circle())
                }
                .padding()
                .background(Color.gray.opacity(0.08))
                .cornerRadius(16)
            }
            
            // Saved places
            HStack(spacing: 12) {
                SavedPlacePill(icon: "house.fill", name: "Home", time: "15 min")
                SavedPlacePill(icon: "briefcase.fill", name: "Office", time: "25 min")
            }
            
            // Vehicle types
            HStack(spacing: 12) {
                ActionCard(title: "Bike", iconName: "bicycle") { viewModel.openLocationSearch() }
                ActionCard(title: "Auto", iconName: "car.2.fill") { viewModel.openLocationSearch() }
                ActionCard(title: "Cab", iconName: "car.fill") { viewModel.openLocationSearch() }
                ActionCard(title: "Parcel", iconName: "cube.box.fill") { }
            }
            
            // Popular places
            VStack(alignment: .leading, spacing: 10) {
                Text("Popular near you").font(.subheadline).fontWeight(.semibold).foregroundColor(.gray)
                ForEach(viewModel.popularDestinations.prefix(3)) { place in
                    Button(action: { viewModel.openLocationSearch() }) {
                        HStack(spacing: 14) {
                            Image(systemName: place.icon).font(.subheadline).foregroundColor(.black).frame(width: 36, height: 36).background(Color.gray.opacity(0.1)).clipShape(Circle())
                            VStack(alignment: .leading, spacing: 2) {
                                Text(place.name).font(.subheadline).fontWeight(.medium).foregroundColor(.primary)
                                Text(place.address).font(.caption2).foregroundColor(.gray)
                            }
                            Spacer()
                            Image(systemName: "arrow.up.right").font(.caption).foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 24).padding(.bottom, 34)
        .background(Color.white).cornerRadius(30)
        .shadow(color: Color.black.opacity(0.12), radius: 25, x: 0, y: -12)
    }
    
    var greetingTime: String {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour < 12 { return "morning" } else if hour < 17 { return "afternoon" } else { return "evening" }
    }
}

// MARK: - Fare Preview Chip
struct FarePreviewChip: View {
    let icon: String
    let label: String
    let fare: Int
    let brandYellow = Color(red: 0.98, green: 0.79, blue: 0.21)
    
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon).font(.subheadline).foregroundColor(.black)
            Text("₹\(fare)").font(.subheadline).fontWeight(.bold)
            Text(label).font(.caption2).foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.gray.opacity(0.06))
        .cornerRadius(12)
    }
}

// MARK: - Saved Place Pill
struct SavedPlacePill: View {
    let icon: String; let name: String; let time: String
    let brandYellow = Color(red: 0.98, green: 0.79, blue: 0.21)
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon).font(.caption).foregroundColor(brandYellow)
            VStack(alignment: .leading, spacing: 1) {
                Text(name).font(.caption).fontWeight(.semibold)
                Text(time).font(.caption2).foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 14).padding(.vertical, 10)
        .background(Color.gray.opacity(0.08)).cornerRadius(12)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct RecentTripBadge: View {
    let ride: Ride
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "clock.arrow.circlepath").foregroundColor(.black)
            VStack(alignment: .leading) {
                Text(ride.destination).font(.subheadline).fontWeight(.medium)
                Text("₹\(Int.random(in: 40...150))").font(.caption).foregroundColor(.gray)
            }
        }
        .padding().background(Color(UIColor.systemGroupedBackground)).cornerRadius(12)
    }
}
