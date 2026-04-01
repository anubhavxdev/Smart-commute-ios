import SwiftUI

struct RideReceiptView: View {
    @Environment(\.dismiss) var dismiss
    let brandYellow = Color(red: 0.98, green: 0.79, blue: 0.21)
    
    let rideId: String
    let date: String
    let pickup: String
    let dropoff: String
    let driverName: String
    let vehicleType: String
    let distance: String
    let duration: String
    let baseFare: Int
    let distanceFare: Int
    let platformFee: Int
    let gst: Int
    let discount: Int
    let totalFare: Int
    let paymentMethod: String
    
    @State private var isDownloaded = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(Color.green.opacity(0.1))
                            .frame(width: 70, height: 70)
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.green)
                    }
                    
                    Text("Ride Completed")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("₹\(totalFare)")
                        .font(.system(size: 44, weight: .black))
                    
                    Text(date)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 30)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                
                // Dashed divider
                DashedDivider()
                    .padding(.horizontal)
                
                // Route
                VStack(spacing: 0) {
                    HStack(spacing: 14) {
                        VStack(spacing: 4) {
                            Circle().fill(Color.green).frame(width: 10, height: 10)
                            ForEach(0..<3, id: \.self) { _ in
                                Circle().fill(Color.gray.opacity(0.3)).frame(width: 2, height: 2)
                            }
                            Circle().fill(Color.red).frame(width: 10, height: 10)
                        }
                        
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("PICKUP")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                                Text(pickup)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                            }
                            VStack(alignment: .leading, spacing: 2) {
                                Text("DROP OFF")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                                Text(dropoff)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(20)
                }
                .background(Color.white)
                
                // Trip stats
                HStack(spacing: 0) {
                    ReceiptStat(value: distance, label: "Distance", icon: "road.lanes")
                    ReceiptStat(value: duration, label: "Duration", icon: "clock")
                    ReceiptStat(value: vehicleType, label: "Vehicle", icon: vehicleType == "Bike" ? "bicycle" : (vehicleType == "Auto" ? "car.2.fill" : "car.fill"))
                }
                .padding(.vertical, 16)
                .background(brandYellow.opacity(0.08))
                
                // Fare breakdown
                VStack(alignment: .leading, spacing: 14) {
                    Text("Fare Breakdown")
                        .font(.headline)
                        .padding(.bottom, 4)
                    
                    ReceiptRow(label: "Base Fare", value: "₹\(baseFare)")
                    ReceiptRow(label: "Distance Charge (\(distance))", value: "₹\(distanceFare)")
                    ReceiptRow(label: "Platform Fee", value: "₹\(platformFee)")
                    ReceiptRow(label: "GST (5%)", value: "₹\(gst)")
                    
                    if discount > 0 {
                        ReceiptRow(label: "Promo Discount", value: "-₹\(discount)", isDiscount: true)
                    }
                    
                    DashedDivider()
                    
                    HStack {
                        Text("Total Amount")
                            .font(.headline)
                        Spacer()
                        Text("₹\(totalFare)")
                            .font(.title2)
                            .fontWeight(.black)
                    }
                }
                .padding(20)
                .background(Color.white)
                
                // Payment method
                HStack(spacing: 12) {
                    Image(systemName: "creditcard.fill")
                        .foregroundColor(.green)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Paid via")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(paymentMethod)
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
                .padding(16)
                .background(Color.green.opacity(0.05))
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.top, 12)
                
                // Driver
                HStack(spacing: 14) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Captain")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(driverName)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.caption2)
                            .foregroundColor(brandYellow)
                        Text("4.8")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                }
                .padding(16)
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Ride ID
                HStack {
                    Text("Ride ID:")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(rideId)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                }
                .padding(.top, 16)
                
                // Actions
                HStack(spacing: 12) {
                    Button(action: {
                        withAnimation(.spring()) { isDownloaded = true }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation { isDownloaded = false }
                        }
                    }) {
                        HStack {
                            Image(systemName: isDownloaded ? "checkmark.circle.fill" : "arrow.down.circle.fill")
                            Text(isDownloaded ? "Saved!" : "Download PDF")
                        }
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(14)
                        .background(brandYellow)
                        .foregroundColor(.black)
                        .cornerRadius(12)
                    }
                    
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                            Text("Share")
                        }
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(14)
                        .background(Color.gray.opacity(0.1))
                        .foregroundColor(.black)
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 20)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Receipt")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ReceiptStat: View {
    let value: String
    let label: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundColor(.black.opacity(0.6))
            Text(value)
                .font(.subheadline)
                .fontWeight(.bold)
            Text(label)
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ReceiptRow: View {
    let label: String
    let value: String
    var isDiscount: Bool = false
    
    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(isDiscount ? .green : .primary)
        }
    }
}

struct DashedDivider: View {
    var body: some View {
        GeometryReader { geo in
            Path { path in
                let dashWidth: CGFloat = 6
                let gapWidth: CGFloat = 4
                var currentX: CGFloat = 0
                
                while currentX < geo.size.width {
                    path.move(to: CGPoint(x: currentX, y: 0))
                    path.addLine(to: CGPoint(x: min(currentX + dashWidth, geo.size.width), y: 0))
                    currentX += dashWidth + gapWidth
                }
            }
            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        }
        .frame(height: 1)
    }
}
