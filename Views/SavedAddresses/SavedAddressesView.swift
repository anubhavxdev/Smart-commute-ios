import SwiftUI

struct SavedAddress: Identifiable {
    let id = UUID()
    var icon: String
    var label: String
    var address: String
    var color: Color
}

struct SavedAddressesView: View {
    let brandYellow = Color.brand
    
    @State private var addresses: [SavedAddress] = [
        SavedAddress(icon: "house.fill", label: "Home", address: "HSR Layout, Sector 2, 27th Main Road, Bangalore - 560102", color: .blue),
        SavedAddress(icon: "briefcase.fill", label: "Office", address: "Koramangala 5th Block, 80 Feet Road, Bangalore - 560095", color: .orange),
        SavedAddress(icon: "dumbbell.fill", label: "Gym", address: "Cult Fitness, Indiranagar 100ft Road, Bangalore - 560038", color: .green),
    ]
    
    @State private var showAddSheet = false
    @State private var newLabel = ""
    @State private var newAddress = ""
    @State private var selectedIcon = "mappin.circle.fill"
    
    let iconOptions = [
        ("mappin.circle.fill", "Custom"),
        ("house.fill", "Home"),
        ("briefcase.fill", "Work"),
        ("graduationcap.fill", "School"),
        ("cart.fill", "Market"),
        ("heart.fill", "Favorite"),
        ("star.fill", "Special"),
        ("dumbbell.fill", "Gym"),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Quick access
                HStack(spacing: 12) {
                    ForEach(addresses.prefix(3)) { addr in
                        VStack(spacing: 8) {
                            ZStack {
                                Circle()
                                    .fill(addr.color.opacity(0.1))
                                    .frame(width: 50, height: 50)
                                Image(systemName: addr.icon)
                                    .foregroundColor(addr.color)
                            }
                            Text(addr.label)
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.white)
                        .cornerRadius(14)
                        .shadow(color: .black.opacity(0.03), radius: 5)
                    }
                }
                .padding(.horizontal)
                
                // Address list
                VStack(spacing: 0) {
                    ForEach(addresses) { address in
                        HStack(spacing: 14) {
                            ZStack {
                                Circle()
                                    .fill(address.color.opacity(0.1))
                                    .frame(width: 44, height: 44)
                                Image(systemName: address.icon)
                                    .foregroundColor(address.color)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(address.label)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Text(address.address)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .lineLimit(2)
                            }
                            
                            Spacer()
                            
                            Menu {
                                Button("Edit") { }
                                Button("Set as Default") { }
                                Button("Delete", role: .destructive) {
                                    withAnimation {
                                        addresses.removeAll { $0.id == address.id }
                                    }
                                }
                            } label: {
                                Image(systemName: "ellipsis")
                                    .foregroundColor(.gray)
                                    .padding(8)
                            }
                        }
                        .padding(16)
                        
                        if address.id != addresses.last?.id {
                            Divider().padding(.leading, 74)
                        }
                    }
                }
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Add new button
                Button(action: { showAddSheet = true }) {
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(brandYellow.opacity(0.15))
                                .frame(width: 44, height: 44)
                            Image(systemName: "plus")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Add New Address")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            Text("Save a frequently visited place")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.horizontal)
                }
                
                // Map tip
                VStack(spacing: 10) {
                    Image(systemName: "map.fill")
                        .font(.system(size: 36))
                        .foregroundColor(brandYellow)
                    
                    Text("Tip: Long-press on the map")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text("You can save any location directly from the map by long-pressing on it.")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .padding(24)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Saved Addresses")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showAddSheet) {
            NavigationStack {
                VStack(spacing: 20) {
                    // Icon selection
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Choose Icon")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(iconOptions, id: \.0) { icon, label in
                                    Button(action: { selectedIcon = icon }) {
                                        VStack(spacing: 4) {
                                            Image(systemName: icon)
                                                .font(.title3)
                                                .frame(width: 44, height: 44)
                                                .background(selectedIcon == icon ? brandYellow : Color.gray.opacity(0.1))
                                                .clipShape(Circle())
                                            Text(label)
                                                .font(.caption2)
                                        }
                                        .foregroundColor(.black)
                                    }
                                }
                            }
                        }
                    }
                    
                    TextField("Label (e.g. Home, Gym)", text: $newLabel)
                        .padding()
                        .background(Color.gray.opacity(0.08))
                        .cornerRadius(10)
                    
                    TextField("Full Address", text: $newAddress, axis: .vertical)
                        .lineLimit(3)
                        .padding()
                        .background(Color.gray.opacity(0.08))
                        .cornerRadius(10)
                    
                    Button(action: {
                        if !newLabel.isEmpty && !newAddress.isEmpty {
                            addresses.append(SavedAddress(
                                icon: selectedIcon,
                                label: newLabel,
                                address: newAddress,
                                color: .teal
                            ))
                            showAddSheet = false
                            newLabel = ""
                            newAddress = ""
                        }
                    }) {
                        Text("Save Address")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(brandYellow)
                            .cornerRadius(12)
                    }
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("Add Address")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") { showAddSheet = false }
                    }
                }
            }
            .presentationDetents([.medium])
        }
    }
}
