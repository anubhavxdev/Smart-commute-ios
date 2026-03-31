import SwiftUI

struct RideDetailView: View {
    let ride: MockHistoryRide
    @Environment(\.dismiss) var dismiss
    
    let brandYellow = Color(red: 0.98, green: 0.79, blue: 0.21)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Status badge
                    HStack {
                        Image(systemName: ride.status == "Completed" ? "checkmark.circle.fill" : "xmark.circle.fill")
                        Text(ride.status)
                            .fontWeight(.semibold)
                    }
                    .font(.subheadline)
                    .foregroundColor(ride.status == "Completed" ? .green : .red)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(ride.status == "Completed" ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
                    .cornerRadius(20)
                    
                    // Route info
                    VStack(spacing: 0) {
                        HStack(spacing: 14) {
                            VStack(spacing: 4) {
                                Circle().fill(Color.green).frame(width: 12, height: 12)
                                ForEach(0..<3, id: \.self) { _ in
                                    Circle().fill(Color.gray.opacity(0.3)).frame(width: 3, height: 3)
                                }
                                Circle().fill(Color.red).frame(width: 12, height: 12)
                            }
                            
                            VStack(alignment: .leading, spacing: 24) {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("PICKUP").font(.caption2).foregroundColor(.gray)
                                    Text(ride.pickup).font(.subheadline).fontWeight(.medium)
                                }
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("DROP OFF").font(.caption2).foregroundColor(.gray)
                                    Text(ride.destination).font(.subheadline).fontWeight(.medium)
                                }
                            }
                            Spacer()
                        }
                        .padding()
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    // Trip stats
                    HStack(spacing: 0) {
                        TripStatItem(icon: "road.lanes", value: ride.distance, label: "Distance")
                        Divider().frame(height: 40)
                        TripStatItem(icon: "clock", value: ride.duration, label: "Duration")
                        Divider().frame(height: 40)
                        TripStatItem(icon: "indianrupeesign.circle", value: "₹\(ride.fare)", label: "Fare")
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    // Fare breakdown
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Fare Breakdown").font(.headline)
                        FareBreakdownRow(label: "Base Fare", value: "₹\(max(ride.fare - 20, 15))")
                        FareBreakdownRow(label: "Distance (\(ride.distance))", value: "₹12")
                        FareBreakdownRow(label: "Platform Fee", value: "₹5")
                        FareBreakdownRow(label: "GST (5%)", value: "₹3")
                        Divider()
                        HStack {
                            Text("Total").font(.headline)
                            Spacer()
                            Text("₹\(ride.fare)").font(.title2).fontWeight(.bold)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    // Driver info
                    HStack(spacing: 14) {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 44))
                            .foregroundColor(.gray)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(ride.driverName).font(.headline)
                            if ride.rating > 0 {
                                HStack(spacing: 4) {
                                    Image(systemName: "star.fill").font(.caption2).foregroundColor(brandYellow)
                                    Text(String(format: "%.1f", ride.rating)).font(.caption)
                                }
                            }
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 4) {
                            Text(ride.vehicleType)
                                .font(.caption).fontWeight(.semibold)
                                .padding(.horizontal, 10).padding(.vertical, 4)
                                .background(brandYellow.opacity(0.2)).cornerRadius(8)
                            Text("KA 01 XX \(Int.random(in: 1000...9999))")
                                .font(.caption2).foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    // Payment
                    HStack {
                        Image(systemName: "creditcard.fill").foregroundColor(.green)
                        Text("Paid via UPI").font(.subheadline)
                        Spacer()
                        Text("₹\(ride.fare)").font(.subheadline).fontWeight(.semibold)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    // Actions
                    HStack(spacing: 12) {
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "doc.text.fill")
                                Text("Invoice")
                            }
                            .frame(maxWidth: .infinity).padding()
                            .background(Color.gray.opacity(0.1)).foregroundColor(.black).cornerRadius(12)
                        }
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "exclamationmark.bubble.fill")
                                Text("Report")
                            }
                            .frame(maxWidth: .infinity).padding()
                            .background(Color.red.opacity(0.1)).foregroundColor(.red).cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("Trip Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill").foregroundColor(.gray)
                    }
                }
            }
        }
    }
}

struct TripStatItem: View {
    let icon: String
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon).font(.caption).foregroundColor(.gray)
            Text(value).font(.headline).fontWeight(.bold)
            Text(label).font(.caption2).foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}

struct FareBreakdownRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label).foregroundColor(.gray)
            Spacer()
            Text(value).fontWeight(.medium)
        }
        .font(.subheadline)
    }
}
