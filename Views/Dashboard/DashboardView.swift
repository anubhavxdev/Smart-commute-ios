import SwiftUI
import MapKit

struct DashboardView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var viewModel = DashboardViewModel()
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $region, showsUserLocation: true)
                .ignoresSafeArea()
            
            // Top Bar
            HStack {
                Button(action: {
                    authViewModel.isLoggedIn = false
                }) {
                    Image(systemName: "line.3.horizontal")
                        .font(.title2)
                        .padding(12)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                .foregroundColor(.black)
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "bell.fill")
                        .font(.title3)
                        .padding(12)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                .foregroundColor(.black)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            // Bottom Sheets driven by State
            VStack {
                Spacer()
                
                switch viewModel.bookingState {
                case .idle:
                    idleSheet
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                case .comparingFares:
                    VehicleSelectionSheet(viewModel: viewModel)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                case .findingCaptain:
                    FindingCaptainSheet(viewModel: viewModel)
                        .transition(.scale.combined(with: .opacity))
                case .rideConfirmed:
                    ActiveRideSheet(viewModel: viewModel)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .animation(.spring(), value: viewModel.bookingState)
    }
    
    var idleSheet: some View {
        VStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 40, height: 5)
                .padding(.top, 10)
            
            Text("Where are you going?")
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.black)
            
            // Search Bar Button (triggers flow)
            Button(action: {
                // Hardcode destination for mock flow
                viewModel.startBooking(destination: "Indiranagar Metro Station")
            }) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                    Text("Search destination...")
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
            
            HStack(spacing: 15) {
                ActionCard(title: "Bike", iconName: "bicycle") { 
                    viewModel.startBooking(destination: "Indiranagar Metro Station")
                }
                ActionCard(title: "Auto", iconName: "car.2.fill") { 
                    viewModel.startBooking(destination: "Indiranagar Metro Station")
                } 
                ActionCard(title: "Cab", iconName: "car.fill") { 
                    viewModel.startBooking(destination: "Indiranagar Metro Station")
                }
                ActionCard(title: "Parcel", iconName: "cube.box.fill") { }
            }
            
            if !viewModel.recentTrips.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Recent Trips")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(viewModel.recentTrips) { ride in
                                RecentTripBadge(ride: ride)
                            }
                        }
                    }
                }
                .padding(.top, 5)
            }
        }
        .padding(.horizontal, 25)
        .padding(.bottom, 30) 
        .background(Color.white)
        .cornerRadius(30)
        .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: -10)
    }
}
