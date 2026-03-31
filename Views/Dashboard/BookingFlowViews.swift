import SwiftUI

let brandYellow = Color(red: 0.98, green: 0.79, blue: 0.21)

struct VehicleSelectionSheet: View {
    @ObservedObject var viewModel: DashboardViewModel
    @State private var selectedVehicle: VehicleType = .bike
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Button(action: {
                    viewModel.cancelBooking()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                
                Text(viewModel.selectedDestination)
                    .font(.headline)
                    .lineLimit(1)
                
                Spacer()
            }
            .padding(.bottom, 5)
            
            VStack(spacing: 12) {
                FareRow(vehicle: .bike, icon: "bicycle", time: "2 min", price: viewModel.fareEstimates[.bike] ?? 40, isSelected: selectedVehicle == .bike)
                    .onTapGesture { selectedVehicle = .bike }
                
                FareRow(vehicle: .auto, icon: "car.2.fill", time: "4 min", price: viewModel.fareEstimates[.auto] ?? 80, isSelected: selectedVehicle == .auto)
                    .onTapGesture { selectedVehicle = .auto }
                
                FareRow(vehicle: .cab, icon: "car.fill", time: "8 min", price: viewModel.fareEstimates[.cab] ?? 200, isSelected: selectedVehicle == .cab)
                    .onTapGesture { selectedVehicle = .cab }
            }
            
            Button(action: {
                viewModel.bookRide(vehicle: selectedVehicle)
            }) {
                Text("Book \(selectedVehicle.rawValue)")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(brandYellow)
                    .cornerRadius(12)
            }
            .padding(.top, 10)
        }
        .padding(25)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: -10)
    }
}

struct FareRow: View {
    let vehicle: VehicleType
    let icon: String
    let time: String
    let price: Int
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .frame(width: 40)
                .foregroundColor(isSelected ? .black : .gray)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(vehicle.rawValue)
                    .font(.headline)
                Text("\(time) drop-off")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text("₹\(price)")
                .font(.headline)
        }
        .padding()
        .background(isSelected ? brandYellow.opacity(0.15) : Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? brandYellow : Color.gray.opacity(0.2), lineWidth: isSelected ? 2 : 1)
        )
        .cornerRadius(12)
    }
}

struct FindingCaptainSheet: View {
    @State private var isPulsing = false
    @ObservedObject var viewModel: DashboardViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Finding nearby \(viewModel.selectedVehicle?.rawValue.lowercased() ?? "captain")s...")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.top, 20)
            
            ZStack {
                Circle()
                    .fill(brandYellow.opacity(0.2))
                    .frame(width: 100, height: 100)
                    .scaleEffect(isPulsing ? 1.5 : 1.0)
                    .opacity(isPulsing ? 0 : 1)
                    .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: false), value: isPulsing)
                
                Circle()
                    .fill(brandYellow)
                    .frame(width: 80, height: 80)
                
                Image(systemName: "magnifyingglass")
                    .font(.title)
                    .foregroundColor(.black)
            }
            .padding(.vertical, 20)
            .onAppear {
                isPulsing = true
            }
            
            Button(action: {
                viewModel.cancelBooking()
            }) {
                Text("Cancel Search")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(12)
            }
        }
        .padding(25)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: -10)
    }
}

struct ActiveRideSheet: View {
    @ObservedObject var viewModel: DashboardViewModel
    var onEndRide: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            HStack {
                Text("Arriving in 3 mins")
                    .font(.headline)
                    .foregroundColor(.green)
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("OTP")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(viewModel.otp)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
            }
            
            Divider()
            
            if let driver = viewModel.assignedDriver {
                HStack(spacing: 16) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(driver.name)
                            .font(.headline)
                        HStack {
                            Image(systemName: "star.fill")
                                .font(.caption2)
                                .foregroundColor(brandYellow)
                            Text(String(format: "%.1f", driver.rating))
                                .font(.caption)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text(driver.plateNumber)
                            .font(.headline)
                            .padding(6)
                            .background(brandYellow.opacity(0.3))
                            .cornerRadius(6)
                            
                        Text(driver.vehicleModel)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                HStack(spacing: 15) {
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "phone.fill")
                            Text("Call")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .foregroundColor(.black)
                        .cornerRadius(12)
                    }
                    
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "message.fill")
                            Text("Message")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .foregroundColor(.black)
                        .cornerRadius(12)
                    }
                }
                
                Button(action: {
                    onEndRide()
                }) {
                    Text("End Ride")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(12)
                }
            }
        }
        .padding(25)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: -10)
    }
}
