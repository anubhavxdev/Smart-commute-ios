import SwiftUI

struct ScheduleRideView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedDate = Date().addingTimeInterval(86400)
    @State private var selectedTime = Date()
    @State private var pickup = "HSR Layout, Sector 2"
    @State private var dropoff = "Koramangala 5th Block"
    @State private var selectedVehicle = "Auto"
    @State private var isRecurring = false
    @State private var selectedDays: Set<String> = ["Mon", "Tue", "Wed", "Thu", "Fri"]
    @State private var isScheduled = false
    @State private var showConfirmation = false
    
    let brandYellow = Color(red: 0.98, green: 0.79, blue: 0.21)
    let vehicles = ["Bike", "Auto", "Cab"]
    let weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header card
                VStack(spacing: 14) {
                    Image(systemName: "calendar.badge.clock")
                        .font(.system(size: 44))
                        .foregroundColor(brandYellow)
                    
                    Text("Schedule a Ride")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Plan your commute ahead of time")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(24)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Route
                VStack(alignment: .leading, spacing: 16) {
                    Text("Route")
                        .font(.headline)
                    
                    HStack(spacing: 14) {
                        VStack(spacing: 4) {
                            Circle().fill(Color.green).frame(width: 10, height: 10)
                            ForEach(0..<3, id: \.self) { _ in
                                Circle().fill(Color.gray.opacity(0.3)).frame(width: 2, height: 2)
                            }
                            Circle().fill(Color.red).frame(width: 10, height: 10)
                        }
                        
                        VStack(spacing: 14) {
                            HStack {
                                TextField("Pickup location", text: $pickup)
                                    .font(.subheadline)
                                    .padding(12)
                                    .background(Color.green.opacity(0.06))
                                    .cornerRadius(10)
                            }
                            HStack {
                                TextField("Drop location", text: $dropoff)
                                    .font(.subheadline)
                                    .padding(12)
                                    .background(Color.red.opacity(0.06))
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Date & Time
                VStack(alignment: .leading, spacing: 16) {
                    Text("Date & Time")
                        .font(.headline)
                    
                    DatePicker("Date", selection: $selectedDate, in: Date()..., displayedComponents: .date)
                        .datePickerStyle(.compact)
                    
                    DatePicker("Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.compact)
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Vehicle Type
                VStack(alignment: .leading, spacing: 14) {
                    Text("Vehicle Type")
                        .font(.headline)
                    
                    HStack(spacing: 12) {
                        ForEach(vehicles, id: \.self) { vehicle in
                            Button(action: {
                                withAnimation(.spring(response: 0.3)) { selectedVehicle = vehicle }
                            }) {
                                VStack(spacing: 8) {
                                    Image(systemName: vehicle == "Bike" ? "bicycle" : (vehicle == "Auto" ? "car.2.fill" : "car.fill"))
                                        .font(.title2)
                                    Text(vehicle)
                                        .font(.caption)
                                        .fontWeight(.medium)
                                    
                                    let fare = vehicle == "Bike" ? "~₹35" : (vehicle == "Auto" ? "~₹75" : "~₹180")
                                    Text(fare)
                                        .font(.caption2)
                                        .foregroundColor(.gray)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(selectedVehicle == vehicle ? brandYellow.opacity(0.15) : Color.gray.opacity(0.05))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(selectedVehicle == vehicle ? brandYellow : Color.clear, lineWidth: 2)
                                )
                                .cornerRadius(12)
                            }
                            .foregroundColor(.black)
                        }
                    }
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Recurring
                VStack(alignment: .leading, spacing: 14) {
                    Toggle(isOn: $isRecurring) {
                        HStack(spacing: 8) {
                            Image(systemName: "repeat")
                                .foregroundColor(brandYellow)
                            Text("Repeat weekly")
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                    }
                    .tint(brandYellow)
                    
                    if isRecurring {
                        HStack(spacing: 8) {
                            ForEach(weekdays, id: \.self) { day in
                                Button(action: {
                                    withAnimation(.spring(response: 0.3)) {
                                        if selectedDays.contains(day) {
                                            selectedDays.remove(day)
                                        } else {
                                            selectedDays.insert(day)
                                        }
                                    }
                                }) {
                                    Text(String(day.prefix(1)))
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .frame(width: 36, height: 36)
                                        .background(selectedDays.contains(day) ? brandYellow : Color.gray.opacity(0.1))
                                        .foregroundColor(selectedDays.contains(day) ? .black : .gray)
                                        .clipShape(Circle())
                                }
                            }
                        }
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Schedule button
                Button(action: {
                    withAnimation(.spring()) { showConfirmation = true }
                }) {
                    HStack {
                        Image(systemName: "calendar.badge.plus")
                        Text("Schedule Ride")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(brandYellow)
                    .cornerRadius(14)
                }
                .padding(.horizontal)
                
                // Upcoming scheduled
                VStack(alignment: .leading, spacing: 12) {
                    Text("Upcoming Scheduled Rides")
                        .font(.headline)
                    
                    ScheduledRideCard(
                        time: "9:00 AM",
                        date: "Tomorrow",
                        route: "Home → Office",
                        vehicle: "Auto",
                        recurring: true,
                        brandYellow: brandYellow
                    )
                    
                    ScheduledRideCard(
                        time: "6:30 PM",
                        date: "Tomorrow",
                        route: "Office → Home",
                        vehicle: "Bike",
                        recurring: true,
                        brandYellow: brandYellow
                    )
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Schedule Ride")
        .navigationBarTitleDisplayMode(.large)
        .alert("Ride Scheduled! 🎉", isPresented: $showConfirmation) {
            Button("Great!", role: .cancel) { }
        } message: {
            Text("Your \(selectedVehicle) ride from \(pickup) to \(dropoff) has been scheduled. You'll be notified 15 minutes before pickup.")
        }
    }
}

struct ScheduledRideCard: View {
    let time: String
    let date: String
    let route: String
    let vehicle: String
    let recurring: Bool
    let brandYellow: Color
    
    var body: some View {
        HStack(spacing: 14) {
            VStack(spacing: 2) {
                Text(time)
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text(date)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .frame(width: 70)
            
            Rectangle()
                .fill(brandYellow)
                .frame(width: 3, height: 40)
                .cornerRadius(2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(route)
                    .font(.subheadline)
                    .fontWeight(.medium)
                HStack(spacing: 8) {
                    Text(vehicle)
                        .font(.caption2)
                        .foregroundColor(.gray)
                    if recurring {
                        HStack(spacing: 2) {
                            Image(systemName: "repeat")
                                .font(.caption2)
                            Text("Weekdays")
                                .font(.caption2)
                        }
                        .foregroundColor(.blue)
                    }
                }
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray.opacity(0.4))
            }
        }
        .padding(14)
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
}
