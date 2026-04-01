import SwiftUI

struct CarpoolMatch: Identifiable {
    let id = UUID()
    let name: String
    let department: String
    let route: String
    let time: String
    let rating: Double
    let rides: Int
    let savings: Int
    let matchPercent: Int
    let avatar: String
}

struct RideSharingView: View {
    @State private var selectedTab = "Find"
    let brandYellow = Color(red: 0.98, green: 0.79, blue: 0.21)
    
    let matches: [CarpoolMatch] = [
        CarpoolMatch(name: "Priya Sharma", department: "Engineering", route: "HSR → Koramangala", time: "9:00 AM", rating: 4.9, rides: 23, savings: 35, matchPercent: 95, avatar: "person.crop.circle.fill"),
        CarpoolMatch(name: "Amit Patel", department: "Design", route: "HSR → Koramangala", time: "9:15 AM", rating: 4.8, rides: 15, savings: 30, matchPercent: 88, avatar: "person.crop.circle.fill"),
        CarpoolMatch(name: "Sneha Reddy", department: "Product", route: "BTM → Koramangala", time: "9:30 AM", rating: 4.7, rides: 8, savings: 25, matchPercent: 72, avatar: "person.crop.circle.fill"),
        CarpoolMatch(name: "Rahul Verma", department: "Marketing", route: "HSR → 5th Block", time: "8:45 AM", rating: 4.6, rides: 31, savings: 40, matchPercent: 68, avatar: "person.crop.circle.fill"),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Hero card
                VStack(spacing: 14) {
                    ZStack {
                        Circle()
                            .fill(Color.green.opacity(0.1))
                            .frame(width: 80, height: 80)
                        Image(systemName: "person.2.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.green)
                    }
                    
                    Text("Share Your Commute")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Split costs with colleagues going the same way")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    
                    // Savings highlight
                    HStack(spacing: 20) {
                        CarpoolStat(icon: "leaf.fill", value: "2.3 kg", label: "CO₂ Saved", color: .green)
                        CarpoolStat(icon: "indianrupeesign.circle.fill", value: "₹1,250", label: "Saved", color: .orange)
                        CarpoolStat(icon: "car.2.fill", value: "18", label: "Shared", color: .blue)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(24)
                .background(
                    LinearGradient(colors: [Color.green.opacity(0.05), Color.blue.opacity(0.05)],
                                   startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.green.opacity(0.15), lineWidth: 1)
                )
                .padding(.horizontal)
                
                // Tab selector
                HStack(spacing: 0) {
                    ForEach(["Find", "My Pools", "Create"], id: \.self) { tab in
                        Button(action: { withAnimation { selectedTab = tab } }) {
                            Text(tab)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(selectedTab == tab ? .black : .gray)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(selectedTab == tab ? brandYellow : Color.clear)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(4)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)
                
                if selectedTab == "Find" {
                    // Route info
                    HStack(spacing: 12) {
                        Image(systemName: "location.fill")
                            .foregroundColor(.green)
                        Text("HSR Layout → Koramangala")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Spacer()
                        Button("Change") { }
                            .font(.caption)
                            .foregroundColor(brandYellow)
                    }
                    .padding(14)
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Matches
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Text("Best Matches")
                                .font(.headline)
                            Spacer()
                            Text("\(matches.count) found")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        ForEach(matches) { match in
                            CarpoolMatchCard(match: match, brandYellow: brandYellow)
                        }
                    }
                    .padding(.horizontal)
                } else if selectedTab == "My Pools" {
                    VStack(spacing: 16) {
                        ActivePoolCard(brandYellow: brandYellow)
                        
                        VStack(spacing: 12) {
                            Image(systemName: "person.2.slash.fill")
                                .font(.system(size: 36))
                                .foregroundColor(.gray.opacity(0.3))
                            Text("No other active pools")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(30)
                    }
                    .padding(.horizontal)
                } else {
                    CreatePoolForm(brandYellow: brandYellow)
                        .padding(.horizontal)
                }
            }
            .padding(.bottom, 20)
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Ride Sharing")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct CarpoolStat: View {
    let icon: String
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundColor(color)
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

struct CarpoolMatchCard: View {
    let match: CarpoolMatch
    let brandYellow: Color
    @State private var isRequested = false
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 14) {
                Image(systemName: match.avatar)
                    .font(.system(size: 40))
                    .foregroundColor(.gray)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(match.name)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        Text("\(match.matchPercent)%")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(4)
                    }
                    
                    Text("\(match.department) • ⭐ \(String(format: "%.1f", match.rating))")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 2) {
                    Text(match.time)
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text("Save ₹\(match.savings)")
                        .font(.caption2)
                        .foregroundColor(.green)
                }
            }
            
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.caption2)
                    Text(match.route)
                        .font(.caption)
                }
                .foregroundColor(.gray)
                
                Spacer()
                
                Button(action: {
                    withAnimation(.spring()) { isRequested = true }
                }) {
                    Text(isRequested ? "Requested ✓" : "Request")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(isRequested ? .green : .black)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(isRequested ? Color.green.opacity(0.1) : brandYellow)
                        .cornerRadius(8)
                }
                .disabled(isRequested)
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.03), radius: 5)
    }
}

struct ActivePoolCard: View {
    let brandYellow: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Tomorrow, 9:00 AM")
                    .font(.subheadline)
                    .fontWeight(.bold)
                Spacer()
                Text("Active")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(6)
            }
            
            Text("HSR Layout → Koramangala 5th Block")
                .font(.caption)
                .foregroundColor(.gray)
            
            HStack(spacing: -8) {
                ForEach(0..<3, id: \.self) { _ in
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 30, height: 30)
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.caption2)
                                .foregroundColor(.white)
                        )
                }
                Text("+1 seat")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.leading, 14)
            }
            
            HStack {
                Text("Estimated fare: ₹25/person")
                    .font(.caption)
                    .foregroundColor(.green)
                Spacer()
                Button("Cancel") { }
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.green.opacity(0.2), lineWidth: 1)
        )
    }
}

struct CreatePoolForm: View {
    let brandYellow: Color
    @State private var seats = 2
    @State private var notes = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Create a Carpool")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Available Seats")
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Stepper("\(seats) seats", value: $seats, in: 1...4)
                    .padding(12)
                    .background(Color.gray.opacity(0.06))
                    .cornerRadius(10)
            }
            
            TextField("Additional notes (optional)", text: $notes, axis: .vertical)
                .lineLimit(3)
                .padding(12)
                .background(Color.gray.opacity(0.06))
                .cornerRadius(10)
            
            Button(action: {}) {
                Text("Create Pool")
                    .fontWeight(.bold)
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
    }
}
