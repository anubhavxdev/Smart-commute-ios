import SwiftUI

struct CommuteInsightsView: View {
    let brandYellow = Color.brand
    @State private var selectedPeriod = "This Month"
    let periods = ["This Week", "This Month", "All Time"]
    
    // Mock data
    let weeklySpend = [120, 85, 145, 90, 110, 0, 0]
    let weekLabels = ["M", "T", "W", "T", "F", "S", "S"]
    
    var totalSpend: Int { 3250 }
    var totalDistance: Double { 156.4 }
    var totalRides: Int { 24 }
    var co2Saved: Double { 12.8 }
    var avgPerDay: Int { 162 }
    
    var maxWeeklySpend: Int { weeklySpend.max() ?? 1 }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Period selector
                HStack(spacing: 0) {
                    ForEach(periods, id: \.self) { period in
                        Button(action: { withAnimation { selectedPeriod = period } }) {
                            Text(period)
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(selectedPeriod == period ? .black : .gray)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(selectedPeriod == period ? brandYellow : Color.clear)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(4)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
                
                // Key metrics
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    InsightMetricCard(icon: "indianrupeesign.circle.fill", value: "₹\(totalSpend)", label: "Total Spent", color: .orange)
                    InsightMetricCard(icon: "road.lanes", value: String(format: "%.1f km", totalDistance), label: "Distance", color: .blue)
                    InsightMetricCard(icon: "car.fill", value: "\(totalRides)", label: "Total Rides", color: .purple)
                    InsightMetricCard(icon: "leaf.fill", value: String(format: "%.1f kg", co2Saved), label: "CO₂ Saved", color: .green)
                }
                .padding(.horizontal)
                
                // Spending Chart
                VStack(alignment: .leading, spacing: 14) {
                    HStack {
                        Text("Weekly Spending")
                            .font(.headline)
                        Spacer()
                        Text("₹\(avgPerDay)/day avg")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    // Bar chart
                    HStack(alignment: .bottom, spacing: 10) {
                        ForEach(Array(zip(weekLabels.indices, weekLabels)), id: \.0) { index, label in
                            VStack(spacing: 6) {
                                if weeklySpend[index] > 0 {
                                    Text("₹\(weeklySpend[index])")
                                        .font(.caption2)
                                        .foregroundColor(.gray)
                                }
                                
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(
                                        weeklySpend[index] > 0 ?
                                        LinearGradient(colors: [brandYellow, .orange], startPoint: .bottom, endPoint: .top) :
                                        LinearGradient(colors: [Color.gray.opacity(0.15)], startPoint: .bottom, endPoint: .top)
                                    )
                                    .frame(height: weeklySpend[index] > 0 ? CGFloat(weeklySpend[index]) / CGFloat(maxWeeklySpend) * 100 : 10)
                                
                                Text(label)
                                    .font(.caption2)
                                    .fontWeight(.medium)
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .frame(height: 140)
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Vehicle breakdown
                VStack(alignment: .leading, spacing: 14) {
                    Text("Vehicle Usage")
                        .font(.headline)
                    
                    VehicleUsageRow(icon: "bicycle", name: "Bike", rides: 12, percent: 50, color: .green)
                    VehicleUsageRow(icon: "car.2.fill", name: "Auto", rides: 8, percent: 33, color: .blue)
                    VehicleUsageRow(icon: "car.fill", name: "Cab", rides: 4, percent: 17, color: .purple)
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Frequent routes
                VStack(alignment: .leading, spacing: 14) {
                    Text("Top Routes")
                        .font(.headline)
                    
                    TopRouteRow(from: "Home", to: "Office", count: 10, avgFare: 75)
                    TopRouteRow(from: "Office", to: "Home", count: 10, avgFare: 80)
                    TopRouteRow(from: "Home", to: "Gym", count: 4, avgFare: 35)
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Environmental impact
                VStack(spacing: 16) {
                    Image(systemName: "leaf.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.green)
                    
                    Text("Eco Impact")
                        .font(.headline)
                    
                    HStack(spacing: 20) {
                        EcoStat(value: String(format: "%.1f kg", co2Saved), label: "CO₂ Saved", icon: "cloud.fill")
                        EcoStat(value: "3", label: "Trees Equivalent", icon: "tree.fill")
                        EcoStat(value: "45 km", label: "Shared Rides", icon: "person.2.fill")
                    }
                    
                    Text("By choosing SmartCommute you've helped reduce carbon emissions equivalent to planting 3 trees! 🌱")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .padding(24)
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(colors: [Color.green.opacity(0.05), Color.teal.opacity(0.05)],
                                   startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.green.opacity(0.15), lineWidth: 1)
                )
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Commute Insights")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct InsightMetricCard: View {
    let icon: String
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .foregroundColor(color)
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(18)
        .background(Color.white)
        .cornerRadius(14)
    }
}

struct VehicleUsageRow: View {
    let icon: String
    let name: String
    let rides: Int
    let percent: Int
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 24)
            
            Text(name)
                .font(.subheadline)
                .fontWeight(.medium)
                .frame(width: 50, alignment: .leading)
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.1))
                    
                    RoundedRectangle(cornerRadius: 4)
                        .fill(color.opacity(0.6))
                        .frame(width: geo.size.width * CGFloat(percent) / 100)
                }
            }
            .frame(height: 8)
            
            Text("\(rides)")
                .font(.caption)
                .fontWeight(.bold)
                .frame(width: 30, alignment: .trailing)
        }
    }
}

struct TopRouteRow: View {
    let from: String
    let to: String
    let count: Int
    let avgFare: Int
    let brandYellow = Color.brand
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "arrow.right.circle.fill")
                .foregroundColor(brandYellow)
            
            Text("\(from) → \(to)")
                .font(.subheadline)
                .fontWeight(.medium)
            
            Spacer()
            
            Text("\(count)x")
                .font(.caption)
                .foregroundColor(.gray)
            
            Text("₹\(avgFare) avg")
                .font(.caption)
                .fontWeight(.semibold)
        }
    }
}

struct EcoStat: View {
    let value: String
    let label: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundColor(.green)
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
