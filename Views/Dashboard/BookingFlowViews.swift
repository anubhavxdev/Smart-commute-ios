import SwiftUI

// MARK: - Custom Corner Radius Extension
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct VehicleSelectionSheet: View {
    @ObservedObject var viewModel: DashboardViewModel
    @State private var selectedVehicle: VehicleType = .bike
    @State private var showPromoSearch = false
    @State private var showSurgeDetails = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Button(action: {
                    HapticManager.shared.selection()
                    viewModel.cancelBooking()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(8)
                        .background(Color.surfaceTertiary)
                        .clipShape(Circle())
                }
                
                Text(viewModel.selectedDestination)
                    .font(.headline)
                    .lineLimit(1)
                
                Spacer()
                
                if viewModel.isSurgeActive {
                    Button(action: { showSurgeDetails = true }) {
                        HStack(spacing: 4) {
                            Image(systemName: "bolt.fill")
                            Text("\(String(format: "%.1f", viewModel.surgeMultiplier))x")
                        }
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.danger)
                        .cornerRadius(8)
                    }
                }
            }
            .padding(.bottom, 5)
            
            VStack(spacing: 12) {
                FareRow(vehicle: .bike, icon: "bicycle", time: "2 min", price: viewModel.fareEstimates[.bike] ?? 40, isSelected: selectedVehicle == .bike)
                    .onTapGesture { 
                        HapticManager.shared.selection()
                        selectedVehicle = .bike 
                    }
                
                FareRow(vehicle: .auto, icon: "car.2.fill", time: "4 min", price: viewModel.fareEstimates[.auto] ?? 80, isSelected: selectedVehicle == .auto)
                    .onTapGesture { 
                        HapticManager.shared.selection()
                        selectedVehicle = .auto 
                    }
                
                FareRow(vehicle: .cab, icon: "car.fill", time: "8 min", price: viewModel.fareEstimates[.cab] ?? 200, isSelected: selectedVehicle == .cab)
                    .onTapGesture { 
                        HapticManager.shared.selection()
                        selectedVehicle = .cab 
                    }
            }
            
            // Promo Code Row
            Button(action: { showPromoSearch = true }) {
                HStack {
                    Image(systemName: "tag.fill")
                        .foregroundColor(viewModel.appliedPromoCode != nil ? .success : .gray)
                    
                    if let code = viewModel.appliedPromoCode {
                        Text("Applied: \(code)")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.success)
                        Text("(-₹\(viewModel.promoDiscount))")
                            .font(.caption)
                            .foregroundColor(.success)
                        
                        Spacer()
                        
                        Button(action: { viewModel.removePromo() }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    } else {
                        Text("Apply Coupon/Promo Code")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(viewModel.appliedPromoCode != nil ? Color.success.opacity(0.05) : Color.surfaceTertiary)
                .cornerRadius(12)
            }
            
            Button(action: {
                HapticManager.shared.success()
                viewModel.bookRide(vehicle: selectedVehicle)
            }) {
                Text("Book \(selectedVehicle.rawValue)")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.brand)
                    .cornerRadius(12)
            }
            .padding(.top, 10)
        }
        .padding(25)
        .background(Color.surfacePrimary)
        .cornerRadius(30, corners: [.topLeft, .topRight])
        .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: -10)
        .sheet(isPresented: $showPromoSearch) {
            PromoCodeView(onApply: { code, discount in
                viewModel.applyPromo(code: code, discount: discount)
            })
        }
        .sheet(isPresented: $showSurgeDetails) {
            SurgePricingView(
                currentMultiplier: viewModel.surgeMultiplier,
                vehicleType: selectedVehicle.rawValue,
                baseFare: Int(Double(viewModel.fareEstimates[selectedVehicle] ?? 100) / viewModel.surgeMultiplier),
                onAccept: { showSurgeDetails = false },
                onDecline: { 
                    showSurgeDetails = false
                    viewModel.cancelBooking()
                }
            )
            .presentationDetents([.medium])
        }
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
        .background(isSelected ? Color.brand.opacity(0.15) : Color.surfacePrimary)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color.brand : Color.gray.opacity(0.2), lineWidth: isSelected ? 2 : 1)
        )
        .cornerRadius(12)
    }
}

struct FindingCaptainSheet: View {
    @State private var isPulsing = false
    @ObservedObject var viewModel: DashboardViewModel
    @State private var showCancelFlow = false
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Finding nearby \(viewModel.selectedVehicle?.rawValue.lowercased() ?? "captain")s...")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.top, 20)
            
            ZStack {
                Circle()
                    .fill(Color.brand.opacity(0.2))
                    .frame(width: 100, height: 100)
                    .scaleEffect(isPulsing ? 1.5 : 1.0)
                    .opacity(isPulsing ? 0 : 1)
                    .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: false), value: isPulsing)
                
                Circle()
                    .fill(Color.brand)
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
                HapticManager.shared.impact(.light)
                showCancelFlow = true
            }) {
                Text("Cancel Search")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.danger)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.danger.opacity(0.1))
                    .cornerRadius(12)
            }
        }
        .padding(25)
        .background(Color.surfacePrimary)
        .cornerRadius(30, corners: [.topLeft, .topRight])
        .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: -10)
        .sheet(isPresented: $showCancelFlow) {
            CancellationView(
                bookingState: .findingCaptain,
                fare: viewModel.fareEstimates[viewModel.selectedVehicle ?? .bike] ?? 0,
                vehicleType: viewModel.selectedVehicle?.rawValue ?? "Ride",
                onConfirmCancel: { reason in
                    viewModel.cancelBooking(reason: reason)
                    showCancelFlow = false
                },
                onGoBack: { showCancelFlow = false }
            )
        }
    }
}

struct ActiveRideSheet: View {
    @ObservedObject var viewModel: DashboardViewModel
    var onEndRide: () -> Void
    @State private var showChat = false
    @State private var showCancelFlow = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Arriving in 3 mins")
                        .font(.headline)
                        .foregroundColor(.success)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "shield.checkered.fill")
                            .font(.caption2)
                            .foregroundColor(.success)
                        Text("Safety Insured")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("OTP")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(viewModel.otp)
                        .font(.title2)
                        .fontWeight(.black)
                        .foregroundColor(.black)
                        .tracking(2)
                }
            }
            
            Divider()
            
            if let driver = viewModel.assignedDriver {
                HStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .fill(Color.surfaceTertiary)
                            .frame(width: 50, height: 50)
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 44))
                            .foregroundColor(.gray)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(driver.name)
                            .font(.headline)
                        HStack {
                            Image(systemName: "star.fill")
                                .font(.caption2)
                                .foregroundColor(Color.brand)
                            Text(String(format: "%.1f", driver.rating))
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(driver.plateNumber)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.brand.opacity(0.3))
                            .cornerRadius(6)
                            
                        Text(driver.vehicleModel)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                HStack(spacing: 15) {
                    Button(action: {
                        HapticManager.shared.impact(.light)
                    }) {
                        HStack {
                            Image(systemName: "phone.fill")
                            Text("Call")
                        }
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.surfaceTertiary)
                        .foregroundColor(.black)
                        .cornerRadius(12)
                    }
                    
                    Button(action: {
                        HapticManager.shared.impact(.light)
                        showChat = true
                    }) {
                        HStack {
                            Image(systemName: "message.fill")
                            Text("Chat")
                        }
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.surfaceTertiary)
                        .foregroundColor(.black)
                        .cornerRadius(12)
                    }
                }
                
                HStack(spacing: 12) {
                    Button(action: {
                        HapticManager.shared.impact(.light)
                        showCancelFlow = true
                    }) {
                        Text("Cancel")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.danger)
                            .frame(width: 80)
                            .padding()
                            .background(Color.danger.opacity(0.1))
                            .cornerRadius(12)
                    }
                    
                    Button(action: {
                        HapticManager.shared.impact(.medium)
                        onEndRide()
                    }) {
                        Text("End Ride")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(12)
                    }
                }
            }
        }
        .padding(25)
        .background(Color.surfacePrimary)
        .cornerRadius(30, corners: [.topLeft, .topRight])
        .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: -10)
        .fullScreenCover(isPresented: $showChat) {
            ChatView(
                driverName: viewModel.assignedDriver?.name ?? "Captain",
                vehicleInfo: "\(viewModel.assignedDriver?.vehicleModel ?? "Vehicle") • \(viewModel.assignedDriver?.plateNumber ?? "")"
            )
        }
        .sheet(isPresented: $showCancelFlow) {
            CancellationView(
                bookingState: .rideConfirmed,
                fare: viewModel.fareEstimates[viewModel.selectedVehicle ?? .bike] ?? 0,
                vehicleType: viewModel.selectedVehicle?.rawValue ?? "Ride",
                onConfirmCancel: { reason in
                    viewModel.cancelBooking(reason: reason)
                    showCancelFlow = false
                },
                onGoBack: { showCancelFlow = false }
            )
        }
    }
}

// MARK: - Dedicated Feature Views (Consolidated to avoid Xcode target issues)

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isFromUser: Bool
    let timestamp: Date
    var isRead: Bool = false
}

struct ChatView: View {
    let driverName: String
    let vehicleInfo: String
    @Environment(\.dismiss) var dismiss
    @State private var messageText = ""
    @State private var messages: [ChatMessage] = []
    @State private var isDriverTyping = false
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack(spacing: 14) {
                    Circle().fill(Color.brand.opacity(0.15)).frame(width: 48, height: 48)
                        .overlay(Image(systemName: "person.crop.circle.fill").foregroundColor(.gray))
                    VStack(alignment: .leading) {
                        Text(driverName).font(.subheadline).bold()
                        Text(vehicleInfo).font(.caption).foregroundColor(.gray)
                    }
                    Spacer()
                }.padding()
                
                Divider()
                
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(messages) { msg in
                            HStack {
                                if msg.isFromUser { Spacer() }
                                Text(msg.text)
                                    .padding()
                                    .background(msg.isFromUser ? Color.brand : Color.gray.opacity(0.1))
                                    .cornerRadius(12)
                                if !msg.isFromUser { Spacer() }
                            }
                        }.padding()
                    }
                }
                
                HStack {
                    TextField("Message...", text: $messageText)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(20)
                    Button(action: {
                        messages.append(ChatMessage(text: messageText, isFromUser: true, timestamp: Date()))
                        messageText = ""
                    }) {
                        Image(systemName: "arrow.up.circle.fill").font(.title)
                    }
                }.padding()
            }
            .navigationTitle("Chat")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }
}

struct PromoCodeView: View {
    @Environment(\.dismiss) var dismiss
    @State private var code = ""
    var onApply: (String, Int) -> Void
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Enter Code", text: $code)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .padding()
                
                Button(action: {
                    onApply(code, 50)
                    dismiss()
                }) {
                    Text("Apply Code").bold().frame(maxWidth: .infinity).padding().background(Color.brand).cornerRadius(12)
                }.padding()
                Spacer()
            }
            .navigationTitle("Promo")
        }
    }
}

struct SurgePricingView: View {
    let currentMultiplier: Double
    let vehicleType: String
    let baseFare: Int
    let onAccept: () -> Void
    let onDecline: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "bolt.fill").font(.largeTitle).foregroundColor(.red)
            Text("Surge pricing is active").font(.headline)
            Text("\(currentMultiplier)x normal fare").font(.title).bold()
            Button(action: onAccept) {
                Text("Accept & Continue").bold().frame(maxWidth: .infinity).padding().background(Color.red).foregroundColor(.white).cornerRadius(12)
            }
            Button(action: onDecline) {
                Text("Decline").foregroundColor(.gray)
            }
        }.padding()
    }
}

struct CancellationView: View {
    let bookingState: BookingState
    let fare: Int
    let vehicleType: String
    let onConfirmCancel: (CancellationReason) -> Void
    let onGoBack: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Why cancel?").font(.headline)
            ForEach(CancellationReason.allCases) { reason in
                Button(action: { onConfirmCancel(reason) }) {
                    Text(reason.rawValue).padding().frame(maxWidth: .infinity).background(Color.gray.opacity(0.1)).cornerRadius(12)
                }
            }
            Button("Go Back", action: onGoBack).foregroundColor(.blue)
        }.padding()
    }
}
