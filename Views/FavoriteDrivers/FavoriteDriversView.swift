import SwiftUI

struct FavoriteDriver: Identifiable {
    let id = UUID()
    let name: String
    let rating: Double
    let rides: Int
    let vehicleType: String
    let vehicleModel: String
    let plateNumber: String
    var isFavorite: Bool
}

struct FavoriteDriversView: View {
    let brandYellow = Color(red: 0.98, green: 0.79, blue: 0.21)
    
    @State private var drivers: [FavoriteDriver] = [
        FavoriteDriver(name: "Raju Kumar", rating: 4.9, rides: 12, vehicleType: "Bike", vehicleModel: "Honda Activa 6G", plateNumber: "KA 01 AB 1234", isFavorite: true),
        FavoriteDriver(name: "Vikram Singh", rating: 4.8, rides: 8, vehicleType: "Cab", vehicleModel: "Maruti Dzire", plateNumber: "KA 05 CD 5678", isFavorite: true),
        FavoriteDriver(name: "Suresh Babu", rating: 4.7, rides: 5, vehicleType: "Auto", vehicleModel: "Bajaj RE", plateNumber: "KA 03 EF 9012", isFavorite: true),
        FavoriteDriver(name: "Arjun Reddy", rating: 4.6, rides: 3, vehicleType: "Cab", vehicleModel: "Hyundai Aura", plateNumber: "KA 02 MN 3456", isFavorite: true),
    ]
    
    @State private var showPreferenceSheet = false
    @State private var preferBikeCaptain = true
    @State private var preferAutoCaptain = true
    @State private var preferCabCaptain = true
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Info banner
                HStack(spacing: 12) {
                    Image(systemName: "heart.circle.fill")
                        .font(.title2)
                        .foregroundColor(.red)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Favorite Drivers")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text("We'll try to assign your favorites when available")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.red.opacity(0.05))
                .cornerRadius(14)
                .padding(.horizontal)
                
                // Driver cards
                ForEach(drivers) { driver in
                    FavoriteDriverCard(driver: driver, brandYellow: brandYellow) {
                        withAnimation(.spring(response: 0.3)) {
                            if let idx = drivers.firstIndex(where: { $0.id == driver.id }) {
                                drivers[idx].isFavorite.toggle()
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                // Preferences
                Button(action: { showPreferenceSheet = true }) {
                    HStack {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(brandYellow)
                        Text("Driver Preferences")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .foregroundColor(.primary)
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(14)
                }
                .padding(.horizontal)
                
                // Empty state hint
                if drivers.filter({ $0.isFavorite }).count == 0 {
                    VStack(spacing: 12) {
                        Image(systemName: "heart.slash.fill")
                            .font(.system(size: 44))
                            .foregroundColor(.gray.opacity(0.3))
                        Text("No favorite drivers yet")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("After a great ride, tap the ❤️ button to save your driver")
                            .font(.caption)
                            .foregroundColor(.gray.opacity(0.7))
                            .multilineTextAlignment(.center)
                    }
                    .padding(30)
                }
                
                // Tip
                VStack(spacing: 10) {
                    Image(systemName: "lightbulb.fill")
                        .foregroundColor(brandYellow)
                    Text("Pro Tip")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text("Drivers you rate 5 stars are automatically suggested as favorites!")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(14)
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Favorite Drivers")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showPreferenceSheet) {
            NavigationStack {
                List {
                    Section("Auto-request favorites for") {
                        Toggle("Bike rides", isOn: $preferBikeCaptain).tint(brandYellow)
                        Toggle("Auto rides", isOn: $preferAutoCaptain).tint(brandYellow)
                        Toggle("Cab rides", isOn: $preferCabCaptain).tint(brandYellow)
                    }
                    
                    Section(footer: Text("When enabled, we'll prioritize your favorite drivers if they're nearby.")) {
                        EmptyView()
                    }
                }
                .navigationTitle("Preferences")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") { showPreferenceSheet = false }
                    }
                }
            }
            .presentationDetents([.medium])
        }
    }
}

struct FavoriteDriverCard: View {
    let driver: FavoriteDriver
    let brandYellow: Color
    let onToggleFavorite: () -> Void
    
    var body: some View {
        VStack(spacing: 14) {
            HStack(spacing: 14) {
                // Avatar
                ZStack {
                    Circle()
                        .fill(Color.gray.opacity(0.15))
                        .frame(width: 56, height: 56)
                    Image(systemName: "person.fill")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(driver.name)
                        .font(.headline)
                    
                    HStack(spacing: 12) {
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .font(.caption2)
                                .foregroundColor(brandYellow)
                            Text(String(format: "%.1f", driver.rating))
                                .font(.caption)
                        }
                        
                        Text("•")
                            .foregroundColor(.gray)
                        
                        Text("\(driver.rides) rides")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                Button(action: onToggleFavorite) {
                    Image(systemName: driver.isFavorite ? "heart.fill" : "heart")
                        .font(.title2)
                        .foregroundColor(driver.isFavorite ? .red : .gray)
                }
            }
            
            // Vehicle info
            HStack(spacing: 14) {
                HStack(spacing: 6) {
                    Image(systemName: driver.vehicleType == "Bike" ? "bicycle" : (driver.vehicleType == "Auto" ? "car.2.fill" : "car.fill"))
                        .font(.caption)
                    Text(driver.vehicleType)
                        .font(.caption)
                        .fontWeight(.medium)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(brandYellow.opacity(0.1))
                .cornerRadius(8)
                
                Text(driver.vehicleModel)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text(driver.plateNumber)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.03), radius: 5)
    }
}
