import SwiftUI

struct CorporateDashboardView: View {
    let brandYellow = Color(red: 0.98, green: 0.79, blue: 0.21)
    
    @State private var selectedMonth = "Mar 2026"
    let months = ["Jan 2026", "Feb 2026", "Mar 2026"]
    
    // Mock data
    let monthlyAllowance = 5000
    let usedAmount = 3250
    let totalRides = 24
    let avgPerRide = 135
    
    var remainingAmount: Int { monthlyAllowance - usedAmount }
    var usagePercent: CGFloat { CGFloat(usedAmount) / CGFloat(monthlyAllowance) }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Company header
                HStack(spacing: 14) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 50, height: 50)
                        Text("TC")
                            .font(.headline)
                            .fontWeight(.black)
                            .foregroundColor(.white)
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("TechCorp Pvt. Ltd.")
                            .font(.headline)
                        Text("Employee ID: TC-2024-0847")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Text("Active")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(6)
                }
                .padding(16)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Budget card
                VStack(spacing: 16) {
                    HStack {
                        Text("Monthly Ride Budget")
                            .font(.headline)
                        Spacer()
                        Picker("Month", selection: $selectedMonth) {
                            ForEach(months, id: \.self) { Text($0) }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    // Progress ring
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.1), lineWidth: 12)
                            .frame(width: 150, height: 150)
                        
                        Circle()
                            .trim(from: 0, to: usagePercent)
                            .stroke(
                                LinearGradient(colors: [brandYellow, .orange], startPoint: .leading, endPoint: .trailing),
                                style: StrokeStyle(lineWidth: 12, lineCap: .round)
                            )
                            .frame(width: 150, height: 150)
                            .rotationEffect(.degrees(-90))
                        
                        VStack(spacing: 4) {
                            Text("₹\(usedAmount)")
                                .font(.title2)
                                .fontWeight(.black)
                            Text("of ₹\(monthlyAllowance)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 10)
                    
                    // Budget stats
                    HStack(spacing: 0) {
                        BudgetStat(label: "Used", value: "₹\(usedAmount)", color: .orange)
                        Divider().frame(height: 30)
                        BudgetStat(label: "Remaining", value: "₹\(remainingAmount)", color: .green)
                        Divider().frame(height: 30)
                        BudgetStat(label: "Rides", value: "\(totalRides)", color: .blue)
                    }
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Quick stats
                HStack(spacing: 12) {
                    CorpQuickStat(icon: "indianrupeesign.circle.fill", value: "₹\(avgPerRide)", label: "Avg/Ride", gradient: [.orange, .red])
                    CorpQuickStat(icon: "clock.fill", value: "9:15 AM", label: "Avg Start", gradient: [.blue, .cyan])
                    CorpQuickStat(icon: "road.lanes", value: "5.2 km", label: "Avg Dist", gradient: [.purple, .pink])
                }
                .padding(.horizontal)
                
                // Policy info
                VStack(alignment: .leading, spacing: 14) {
                    HStack(spacing: 8) {
                        Image(systemName: "doc.text.fill")
                            .foregroundColor(.blue)
                        Text("Company Policy")
                            .font(.headline)
                    }
                    
                    PolicyRow(icon: "checkmark.circle.fill", text: "Bikes, Autos & Cabs allowed", isAllowed: true)
                    PolicyRow(icon: "checkmark.circle.fill", text: "Office commute (Mon-Fri)", isAllowed: true)
                    PolicyRow(icon: "checkmark.circle.fill", text: "Max ₹5,000/month allowance", isAllowed: true)
                    PolicyRow(icon: "xmark.circle.fill", text: "Personal rides not covered", isAllowed: false)
                    PolicyRow(icon: "xmark.circle.fill", text: "Weekend rides not covered", isAllowed: false)
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Recent team rides
                VStack(alignment: .leading, spacing: 14) {
                    HStack {
                        HStack(spacing: 8) {
                            Image(systemName: "person.3.fill")
                                .foregroundColor(.purple)
                            Text("Team Activity")
                                .font(.headline)
                        }
                        Spacer()
                        Text("This week")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    TeamMateRow(name: "Priya S.", rides: 5, amount: 680)
                    TeamMateRow(name: "Amit P.", rides: 4, amount: 520)
                    TeamMateRow(name: "You", rides: 6, amount: 810)
                    TeamMateRow(name: "Sneha R.", rides: 3, amount: 390)
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Expense report
                Button(action: {}) {
                    HStack {
                        Image(systemName: "doc.richtext.fill")
                        Text("Download Expense Report")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(brandYellow)
                    .cornerRadius(14)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Corporate")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct BudgetStat: View {
    let label: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(color)
            Text(label)
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}

struct CorpQuickStat: View {
    let icon: String
    let value: String
    let label: String
    let gradient: [Color]
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(LinearGradient(colors: gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
                .clipShape(Circle())
            Text(value)
                .font(.subheadline)
                .fontWeight(.bold)
            Text(label)
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(Color.white)
        .cornerRadius(14)
    }
}

struct PolicyRow: View {
    let icon: String
    let text: String
    let isAllowed: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .foregroundColor(isAllowed ? .green : .red)
                .font(.caption)
            Text(text)
                .font(.subheadline)
                .foregroundColor(isAllowed ? .primary : .gray)
        }
    }
}

struct TeamMateRow: View {
    let name: String
    let rides: Int
    let amount: Int
    let brandYellow = Color(red: 0.98, green: 0.79, blue: 0.21)
    
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: 34, height: 34)
                .overlay(
                    Text(String(name.prefix(1)))
                        .font(.caption)
                        .fontWeight(.bold)
                )
            
            Text(name)
                .font(.subheadline)
                .fontWeight(name == "You" ? .bold : .regular)
            
            Spacer()
            
            Text("\(rides) rides")
                .font(.caption)
                .foregroundColor(.gray)
            
            Text("₹\(amount)")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: 60, alignment: .trailing)
        }
    }
}
