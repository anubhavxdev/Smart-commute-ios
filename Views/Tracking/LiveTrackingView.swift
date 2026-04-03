import SwiftUI
import MapKit

struct LiveTrackingView: View {
    @Environment(\.dismiss) var dismiss
    @State private var driverProgress: CGFloat = 0.0
    @State private var etaMinutes = 8
    @State private var isPulsing = false
    @State private var showSOS = false
    
    let driverName: String
    let plateNumber: String
    let vehicleModel: String
    let brandYellow = Color.brand
    
    var body: some View {
        ZStack {
            // Map placeholder
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            
            // Simulated map with route
            ZStack {
                // Route visualization
                GeometryReader { geo in
                    Path { path in
                        let width = geo.size.width
                        let height = geo.size.height
                        path.move(to: CGPoint(x: width * 0.15, y: height * 0.65))
                        path.addCurve(
                            to: CGPoint(x: width * 0.85, y: height * 0.25),
                            control1: CGPoint(x: width * 0.4, y: height * 0.45),
                            control2: CGPoint(x: width * 0.6, y: height * 0.35)
                        )
                    }
                    .stroke(Color.blue.opacity(0.3), lineWidth: 4)
                    .overlay(
                        Path { path in
                            let width = geo.size.width
                            let height = geo.size.height
                            path.move(to: CGPoint(x: width * 0.15, y: height * 0.65))
                            path.addCurve(
                                to: CGPoint(x: width * 0.85, y: height * 0.25),
                                control1: CGPoint(x: width * 0.4, y: height * 0.45),
                                control2: CGPoint(x: width * 0.6, y: height * 0.35)
                            )
                        }
                        .trim(from: 0, to: driverProgress)
                        .stroke(Color.blue, lineWidth: 4)
                    )
                    
                    // Pickup pin
                    Image(systemName: "mappin.circle.fill")
                        .font(.title)
                        .foregroundColor(.green)
                        .position(x: geo.size.width * 0.15, y: geo.size.height * 0.65)
                    
                    // Drop pin
                    Image(systemName: "mappin.circle.fill")
                        .font(.title)
                        .foregroundColor(.red)
                        .position(x: geo.size.width * 0.85, y: geo.size.height * 0.25)
                    
                    // Driver icon (moving)
                    let driverX = geo.size.width * 0.15 + (geo.size.width * 0.7) * driverProgress
                    let driverY = geo.size.height * 0.65 - (geo.size.height * 0.4) * driverProgress
                    
                    ZStack {
                        Circle()
                            .fill(brandYellow.opacity(0.3))
                            .frame(width: 50, height: 50)
                            .scaleEffect(isPulsing ? 1.5 : 1)
                            .opacity(isPulsing ? 0 : 0.5)
                        
                        Circle()
                            .fill(brandYellow)
                            .frame(width: 36, height: 36)
                        
                        Image(systemName: "car.fill")
                            .font(.caption)
                            .foregroundColor(.black)
                    }
                    .position(x: driverX, y: driverY)
                }
            }
            .padding(.bottom, 300)
            
            // Top bar
            VStack {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .padding(12)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                    }
                    .foregroundColor(.black)
                    
                    Spacer()
                    
                    // ETA Badge
                    HStack(spacing: 6) {
                        Image(systemName: "clock.fill")
                            .font(.caption)
                        Text("ETA: \(etaMinutes) min")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    
                    Spacer()
                    
                    // SOS Button
                    Button(action: { showSOS = true }) {
                        Text("SOS")
                            .font(.caption)
                            .fontWeight(.black)
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.red)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Spacer()
            }
            
            // Bottom card
            VStack {
                Spacer()
                
                VStack(spacing: 16) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 40, height: 5)
                        .padding(.top, 12)
                    
                    // Progress bar
                    VStack(spacing: 8) {
                        HStack {
                            Text("Driver is on the way")
                                .font(.headline)
                            Spacer()
                            Text("\(Int(driverProgress * 100))%")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(brandYellow)
                        }
                        
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.15))
                                    .frame(height: 6)
                                
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(brandYellow)
                                    .frame(width: geo.size.width * driverProgress, height: 6)
                            }
                        }
                        .frame(height: 6)
                    }
                    
                    Divider()
                    
                    // Driver info
                    HStack(spacing: 14) {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.gray)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(driverName)
                                .font(.headline)
                            HStack {
                                Image(systemName: "star.fill")
                                    .font(.caption2)
                                    .foregroundColor(brandYellow)
                                Text("4.8")
                                    .font(.caption)
                            }
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 4) {
                            Text(plateNumber)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(brandYellow.opacity(0.3))
                                .cornerRadius(6)
                            Text(vehicleModel)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    // Action buttons
                    HStack(spacing: 12) {
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "phone.fill")
                                Text("Call")
                            }
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity)
                            .padding(14)
                            .background(Color.green.opacity(0.1))
                            .foregroundColor(.green)
                            .cornerRadius(12)
                        }
                        
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "message.fill")
                                Text("Chat")
                            }
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity)
                            .padding(14)
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .cornerRadius(12)
                        }
                        
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "square.and.arrow.up.fill")
                                Text("Share")
                            }
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity)
                            .padding(14)
                            .background(Color.purple.opacity(0.1))
                            .foregroundColor(.purple)
                            .cornerRadius(12)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 34)
                .background(Color.white)
                .cornerRadius(30)
                .shadow(color: .black.opacity(0.12), radius: 25, x: 0, y: -12)
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationBarHidden(true)
        .onAppear {
            isPulsing = true
            simulateDriverMovement()
        }
        .alert("Emergency SOS", isPresented: $showSOS) {
            Button("Call 112", role: .destructive) { }
            Button("Share Live Location") { }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Your live location will be shared with emergency contacts and authorities.")
        }
    }
    
    func simulateDriverMovement() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            withAnimation(.easeInOut(duration: 0.4)) {
                if driverProgress < 1.0 {
                    driverProgress += 0.015
                    etaMinutes = max(1, Int((1.0 - driverProgress) * 8))
                } else {
                    timer.invalidate()
                }
            }
        }
    }
}
