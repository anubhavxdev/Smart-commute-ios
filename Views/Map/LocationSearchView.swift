import SwiftUI
import MapKit

struct LocationSearchView: View {
    @ObservedObject var viewModel: DashboardViewModel
    @State private var pickupText: String = "Current Location"
    @State private var destinationText: String = ""
    @FocusState private var focusedField: SearchField?
    
    enum SearchField { case pickup, destination }
    
    let brandYellow = Color.brand
    
    // Predefined locations with coordinates
    let suggestions: [SearchSuggestion] = [
        SearchSuggestion(name: "Indiranagar Metro Station", address: "100 Feet Rd, Indiranagar", lat: 12.9784, lng: 77.6408, icon: "tram.fill"),
        SearchSuggestion(name: "Koramangala 5th Block", address: "80 Feet Rd, Koramangala", lat: 12.9352, lng: 77.6245, icon: "building.2.fill"),
        SearchSuggestion(name: "MG Road", address: "MG Road, Bangalore", lat: 12.9756, lng: 77.6066, icon: "cart.fill"),
        SearchSuggestion(name: "Kempegowda Airport T1", address: "KIAL, Devanahalli", lat: 13.1986, lng: 77.7066, icon: "airplane"),
        SearchSuggestion(name: "Whitefield ITPL", address: "ITPL Main Road, Whitefield", lat: 12.9698, lng: 77.7500, icon: "laptopcomputer"),
        SearchSuggestion(name: "Electronic City Phase 1", address: "Hosur Rd, Electronic City", lat: 12.8440, lng: 77.6610, icon: "cpu"),
        SearchSuggestion(name: "HSR Layout Sector 2", address: "27th Main, HSR Layout", lat: 12.9116, lng: 77.6389, icon: "house.fill"),
        SearchSuggestion(name: "BTM Layout 2nd Stage", address: "16th Main, BTM Layout", lat: 12.9166, lng: 77.6101, icon: "building.fill"),
        SearchSuggestion(name: "Jayanagar 4th Block", address: "11th Main, Jayanagar", lat: 12.9250, lng: 77.5838, icon: "tree.fill"),
        SearchSuggestion(name: "Silk Board Junction", address: "Hosur Rd, Silk Board", lat: 12.9177, lng: 77.6233, icon: "road.lanes"),
    ]
    
    var filteredSuggestions: [SearchSuggestion] {
        if destinationText.isEmpty { return suggestions }
        return suggestions.filter {
            $0.name.localizedCaseInsensitiveContains(destinationText) ||
            $0.address.localizedCaseInsensitiveContains(destinationText)
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button(action: {
                    viewModel.cancelBooking()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                Spacer()
                Text("Plan your ride")
                    .font(.headline)
                Spacer()
                Color.clear.frame(width: 30)
            }
            .padding()
            
            // Input fields
            VStack(spacing: 0) {
                HStack(spacing: 14) {
                    VStack(spacing: 4) {
                        Circle().fill(Color.green).frame(width: 12, height: 12)
                        ForEach(0..<3, id: \.self) { _ in
                            Circle().fill(Color.gray.opacity(0.3)).frame(width: 3, height: 3)
                        }
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    VStack(spacing: 12) {
                        // Pickup
                        TextField("Current Location", text: $pickupText)
                            .font(.subheadline)
                            .padding(12)
                            .background(Color.green.opacity(0.08))
                            .cornerRadius(10)
                            .focused($focusedField, equals: .pickup)
                        
                        // Destination
                        TextField("Where to?", text: $destinationText)
                            .font(.subheadline)
                            .padding(12)
                            .background(Color.gray.opacity(0.08))
                            .cornerRadius(10)
                            .focused($focusedField, equals: .destination)
                    }
                }
                .padding()
            }
            .background(Color.white)
            
            Divider()
            
            // Suggestions
            ScrollView {
                LazyVStack(spacing: 0) {
                    // Saved places
                    if destinationText.isEmpty {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("SAVED PLACES")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                                .padding(.horizontal, 20)
                                .padding(.top, 16)
                                .padding(.bottom, 8)
                            
                            SavedPlaceRow(icon: "house.fill", name: "Home", address: "HSR Layout, Sector 2", color: .blue) {
                                selectDestination(SearchSuggestion(name: "HSR Layout Sector 2", address: "HSR Layout", lat: 12.9116, lng: 77.6389, icon: "house.fill"))
                            }
                            
                            SavedPlaceRow(icon: "briefcase.fill", name: "Office", address: "Koramangala 5th Block", color: .orange) {
                                selectDestination(SearchSuggestion(name: "Koramangala 5th Block", address: "Koramangala", lat: 12.9352, lng: 77.6245, icon: "briefcase.fill"))
                            }
                        }
                        
                        Divider().padding(.vertical, 8)
                        
                        Text("NEARBY PLACES")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 8)
                    }
                    
                    ForEach(filteredSuggestions) { suggestion in
                        Button(action: {
                            selectDestination(suggestion)
                        }) {
                            HStack(spacing: 14) {
                                Image(systemName: suggestion.icon)
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .frame(width: 36, height: 36)
                                    .background(Color.gray.opacity(0.1))
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading, spacing: 3) {
                                    Text(suggestion.name)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(.primary)
                                    Text(suggestion.address)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "arrow.up.left")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                        }
                        
                        Divider().padding(.leading, 70)
                    }
                }
            }
        }
        .background(Color.white)
        .cornerRadius(0)
        .onAppear {
            focusedField = .destination
        }
    }
    
    func selectDestination(_ suggestion: SearchSuggestion) {
        let dropCoord = CLLocationCoordinate2D(latitude: suggestion.lat, longitude: suggestion.lng)
        viewModel.confirmLocations(
            pickupName: pickupText.isEmpty ? "Current Location" : pickupText,
            dropName: suggestion.name,
            dropCoordinate: dropCoord
        )
    }
}

// MARK: - Models
struct SearchSuggestion: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let lat: Double
    let lng: Double
    let icon: String
}

struct SavedPlaceRow: View {
    let icon: String
    let name: String
    let address: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .frame(width: 36, height: 36)
                    .background(color)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(name)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    Text(address)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
    }
}
