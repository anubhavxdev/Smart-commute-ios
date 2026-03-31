import SwiftUI

struct RideHistoryView: View {
    let brandYellow = Color(red: 0.98, green: 0.79, blue: 0.21)
    @State private var selectedFilter = "All"
    let filters = ["All", "Bike", "Auto", "Cab"]
    
    let rides: [MockHistoryRide] = [
        MockHistoryRide(destination: "Koramangala 5th Block", pickup: "HSR Layout Sector 2", date: "Today", time: "9:30 AM", fare: 45, vehicleType: "Bike", driverName: "Raju Kumar", rating: 4.8, distance: "3.2 km", duration: "12 min", status: "Completed"),
        MockHistoryRide(destination: "Airport T2", pickup: "Indiranagar 100ft Road", date: "Yesterday", time: "6:15 AM", fare: 380, vehicleType: "Cab", driverName: "Vikram Singh", rating: 4.9, distance: "38 km", duration: "55 min", status: "Completed"),
        MockHistoryRide(destination: "MG Road Metro Station", pickup: "Koramangala 4th Block", date: "28 Mar", time: "8:00 PM", fare: 65, vehicleType: "Auto", driverName: "Suresh Babu", rating: 4.6, distance: "5.1 km", duration: "18 min", status: "Completed"),
        MockHistoryRide(destination: "Whitefield ITPL", pickup: "MG Road", date: "27 Mar", time: "10:45 AM", fare: 220, vehicleType: "Cab", driverName: "Arjun Reddy", rating: 0, distance: "18 km", duration: "-", status: "Cancelled"),
        MockHistoryRide(destination: "Electronic City Phase 1", pickup: "Silk Board Junction", date: "27 Mar", time: "7:30 AM", fare: 55, vehicleType: "Bike", driverName: "Mohan Das", rating: 4.7, distance: "8.5 km", duration: "22 min", status: "Completed"),
        MockHistoryRide(destination: "Jayanagar 4th Block", pickup: "BTM Layout", date: "26 Mar", time: "1:15 PM", fare: 40, vehicleType: "Bike", driverName: "Kiran M", rating: 4.5, distance: "2.8 km", duration: "10 min", status: "Completed"),
        MockHistoryRide(destination: "Marathahalli Bridge", pickup: "Indiranagar", date: "25 Mar", time: "6:30 PM", fare: 95, vehicleType: "Auto", driverName: "Prakash R", rating: 4.3, distance: "7.2 km", duration: "25 min", status: "Completed"),
        MockHistoryRide(destination: "Hebbal Flyover", pickup: "Yeshwanthpur", date: "24 Mar", time: "8:00 AM", fare: 70, vehicleType: "Auto", driverName: "Naveen S", rating: 4.8, distance: "4.5 km", duration: "15 min", status: "Completed"),
        MockHistoryRide(destination: "Bannerghatta Road", pickup: "JP Nagar", date: "23 Mar", time: "4:45 PM", fare: 180, vehicleType: "Cab", driverName: "Deepak L", rating: 4.9, distance: "12 km", duration: "35 min", status: "Completed"),
    ]
    
    var filteredRides: [MockHistoryRide] {
        if selectedFilter == "All" { return rides }
        return rides.filter { $0.vehicleType == selectedFilter }
    }
    
    @State private var selectedRide: MockHistoryRide?
    
    var body: some View {
        VStack(spacing: 0) {
            // Summary card
            HStack(spacing: 20) {
                StatBubble(value: "\(rides.count)", label: "Total Rides", icon: "car.fill")
                StatBubble(value: "₹\(rides.filter { $0.status == "Completed" }.reduce(0) { $0 + $1.fare })", label: "Total Spent", icon: "indianrupeesign.circle.fill")
                StatBubble(value: "4.7", label: "Avg Rating", icon: "star.fill")
            }
            .padding()
            .background(brandYellow.opacity(0.1))
            
            // Filter chips
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(filters, id: \.self) { filter in
                        Button(action: {
                            withAnimation(.spring(response: 0.3)) {
                                selectedFilter = filter
                            }
                        }) {
                            Text(filter)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(selectedFilter == filter ? .black : .gray)
                                .padding(.horizontal, 18)
                                .padding(.vertical, 8)
                                .background(selectedFilter == filter ? brandYellow : Color.gray.opacity(0.1))
                                .cornerRadius(20)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
            }
            
            // Rides list
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(Array(filteredRides.enumerated()), id: \.element.id) { index, ride in
                        Button(action: { selectedRide = ride }) {
                            HStack(spacing: 14) {
                                ZStack {
                                    Circle()
                                        .fill(ride.status == "Cancelled" ? Color.red.opacity(0.1) : brandYellow.opacity(0.15))
                                        .frame(width: 48, height: 48)
                                    
                                    Image(systemName: ride.vehicleType == "Bike" ? "bicycle" : (ride.vehicleType == "Auto" ? "car.2.fill" : "car.fill"))
                                        .foregroundColor(ride.status == "Cancelled" ? .red : .black)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(ride.destination)
                                        .font(.system(size: 15, weight: .semibold))
                                        .foregroundColor(.primary)
                                    
                                    HStack(spacing: 8) {
                                        Text(ride.date)
                                        Text("•")
                                        Text(ride.distance)
                                    }
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    
                                    if ride.status == "Cancelled" {
                                        Text("Cancelled")
                                            .font(.caption2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.red)
                                    } else if ride.rating > 0 {
                                        HStack(spacing: 2) {
                                            ForEach(1...5, id: \.self) { star in
                                                Image(systemName: star <= Int(ride.rating) ? "star.fill" : "star")
                                                    .font(.system(size: 9))
                                                    .foregroundColor(brandYellow)
                                            }
                                        }
                                    }
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text("₹\(ride.fare)")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    Text(ride.vehicleType)
                                        .font(.caption2)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.03), radius: 8, x: 0, y: 2)
                        }
                        .buttonStyle(.plain)
                        .opacity(1)
                    }
                }
                .padding()
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("My Rides")
        .navigationBarTitleDisplayMode(.large)
        .sheet(item: $selectedRide) { ride in
            RideDetailView(ride: ride)
        }
    }
}

struct StatBubble: View {
    let value: String
    let label: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundColor(.black.opacity(0.6))
            Text(value)
                .font(.headline)
                .fontWeight(.bold)
            Text(label)
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}

struct MockHistoryRide: Identifiable {
    let id = UUID()
    let destination: String
    let pickup: String
    let date: String
    let time: String
    let fare: Int
    let vehicleType: String
    let driverName: String
    let rating: Double
    let distance: String
    let duration: String
    let status: String
}
