import SwiftUI

struct FareEstimatorView: View {
    @State private var pickup = "HSR Layout, Sector 2"
    @State private var dropoff = ""
    @State private var estimatedDistance = 0.0
    @State private var showEstimate = false
    
    let brandYellow = Color.brand
    
    let quickDestinations = [
        ("Koramangala 5th Block", 3.2),
        ("Indiranagar Metro", 6.8),
        ("MG Road", 8.1),
        ("Airport T1", 38.0),
        ("Electronic City", 12.5),
        ("Whitefield", 22.0),
    ]
    
    var bikeFare: ClosedRange<Int> {
        let base = max(25, Int(estimatedDistance * 10))
        return base...(base + 15)
    }
    var autoFare: ClosedRange<Int> {
        let base = max(35, Int(estimatedDistance * 16))
        return base...(base + 25)
    }
    var cabFare: ClosedRange<Int> {
        let base = max(80, Int(estimatedDistance * 32))
        return base...(base + 40)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Route Input
                VStack(alignment: .leading, spacing: 16) {
                    Text("Check Fare")
                        .font(.headline)
                    
                    HStack(spacing: 14) {
                        VStack(spacing: 4) {
                            Circle().fill(Color.green).frame(width: 10, height: 10)
                            ForEach(0..<3, id: \.self) { _ in
                                Circle().fill(Color.gray.opacity(0.3)).frame(width: 2, height: 2)
                            }
                            Circle().fill(Color.red).frame(width: 10, height: 10)
                        }
                        
                        VStack(spacing: 12) {
                            TextField("Pickup location", text: $pickup)
                                .font(.subheadline)
                                .padding(12)
                                .background(Color.green.opacity(0.06))
                                .cornerRadius(10)
                            
                            TextField("Where to?", text: $dropoff)
                                .font(.subheadline)
                                .padding(12)
                                .background(Color.gray.opacity(0.06))
                                .cornerRadius(10)
                        }
                    }
                    
                    Button(action: {
                        if !dropoff.isEmpty {
                            withAnimation(.spring()) {
                                estimatedDistance = Double.random(in: 2...15)
                                showEstimate = true
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("Estimate Fare")
                                .fontWeight(.bold)
                        }
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(brandYellow)
                        .cornerRadius(12)
                    }
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Quick destinations
                if !showEstimate {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Popular Routes")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ForEach(quickDestinations, id: \.0) { dest, dist in
                            Button(action: {
                                dropoff = dest
                                withAnimation(.spring()) {
                                    estimatedDistance = dist
                                    showEstimate = true
                                }
                            }) {
                                HStack(spacing: 14) {
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundColor(.red.opacity(0.6))
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(dest)
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                        Text(String(format: "%.1f km from %@", dist, pickup.components(separatedBy: ",").first ?? "here"))
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    Spacer()
                                    
                                    Text("~₹\(max(25, Int(dist * 12)))")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(brandYellow)
                                }
                                .foregroundColor(.primary)
                                .padding(14)
                            }
                            Divider().padding(.leading, 50)
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.horizontal)
                }
                
                // Fare estimates
                if showEstimate {
                    // Distance badge
                    HStack {
                        Image(systemName: "road.lanes")
                            .foregroundColor(.gray)
                        Text(String(format: "%.1f km", estimatedDistance))
                            .fontWeight(.bold)
                        Text("•")
                            .foregroundColor(.gray)
                        Text("~\(max(5, Int(estimatedDistance * 2.5))) min")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.white)
                    .cornerRadius(20)
                    
                    VStack(spacing: 12) {
                        FareEstimateCard(
                            icon: "bicycle",
                            name: "Bike",
                            fareRange: bikeFare,
                            eta: "\(max(2, Int(estimatedDistance * 1.5))) min",
                            color: .green,
                            brandYellow: brandYellow
                        )
                        
                        FareEstimateCard(
                            icon: "car.2.fill",
                            name: "Auto",
                            fareRange: autoFare,
                            eta: "\(max(3, Int(estimatedDistance * 2))) min",
                            color: .blue,
                            brandYellow: brandYellow
                        )
                        
                        FareEstimateCard(
                            icon: "car.fill",
                            name: "Cab",
                            fareRange: cabFare,
                            eta: "\(max(5, Int(estimatedDistance * 2.5))) min",
                            color: .purple,
                            brandYellow: brandYellow
                        )
                    }
                    .padding(.horizontal)
                    
                    // Fare note
                    HStack(spacing: 8) {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.blue)
                        Text("Actual fare may vary based on traffic, demand & route")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.05))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    Button(action: {
                        withAnimation(.spring()) {
                            showEstimate = false
                            dropoff = ""
                        }
                    }) {
                        Text("Check Another Route")
                            .font(.subheadline)
                            .foregroundColor(brandYellow)
                    }
                    .padding(.bottom, 20)
                }
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Fare Estimator")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct FareEstimateCard: View {
    let icon: String
    let name: String
    let fareRange: ClosedRange<Int>
    let eta: String
    let color: Color
    let brandYellow: Color
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.1))
                    .frame(width: 50, height: 50)
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(color)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.headline)
                HStack(spacing: 8) {
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.caption2)
                        Text(eta)
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text("₹\(fareRange.lowerBound) – ₹\(fareRange.upperBound)")
                    .font(.headline)
                    .fontWeight(.bold)
                Text("estimated")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.03), radius: 5)
    }
}
