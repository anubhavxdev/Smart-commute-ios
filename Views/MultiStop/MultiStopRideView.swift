import SwiftUI

struct MultiStopRideView: View {
    @Environment(\.dismiss) var dismiss
    let brandYellow = Color(red: 0.98, green: 0.79, blue: 0.21)
    
    @State private var stops: [RideStop] = [
        RideStop(name: "HSR Layout, Sector 2", type: .pickup),
        RideStop(name: "", type: .stop),
        RideStop(name: "", type: .dropoff),
    ]
    
    @State private var selectedVehicle = "Cab"
    @State private var estimatedFare = 0
    @State private var estimatedTime = 0
    @State private var showEstimate = false
    
    let suggestedStops = [
        "Silk Board Junction",
        "Koramangala 5th Block",
        "Indiranagar Metro",
        "MG Road",
        "Whitefield ITPL",
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                infoHeader
                stopsSection
                suggestedSection
                vehicleSection
                estimateButton
                
                if showEstimate {
                    estimateResultSection
                }
            }
            .padding(.bottom, 20)
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Multi-Stop")
        .navigationBarTitleDisplayMode(.large)
    }
    
    // MARK: - Info Header
    private var infoHeader: some View {
        HStack(spacing: 12) {
            Image(systemName: "point.3.connected.trianglepath.dotted")
                .font(.title2)
                .foregroundColor(brandYellow)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Multi-Stop Ride")
                    .font(.headline)
                Text("Add up to 3 intermediate stops")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(brandYellow.opacity(0.08))
        .cornerRadius(14)
        .padding(.horizontal)
    }
    
    // MARK: - Stops List
    private var stopsSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(stops.indices, id: \.self) { index in
                stopRowView(at: index)
            }
            
            if stops.count < 5 {
                Button(action: {
                    withAnimation(.spring()) {
                        stops.insert(RideStop(name: "", type: .stop), at: stops.count - 1)
                    }
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(brandYellow)
                        Text("Add a stop")
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 48)
                    .padding(.vertical, 12)
                }
            }
        }
        .padding(.vertical, 16)
        .background(Color.white)
        .cornerRadius(16)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func stopRowView(at index: Int) -> some View {
        let stop = stops[index]
        HStack(spacing: 14) {
            VStack(spacing: 0) {
                Circle()
                    .fill(stopColor(for: stop.type))
                    .frame(width: 14, height: 14)
                
                if index < stops.count - 1 {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 2, height: 54)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(stopLabel(for: stop.type, index: index))
                    .font(.caption2)
                    .foregroundColor(.gray)
                
                TextField("Enter location", text: $stops[index].name)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color.gray.opacity(0.06))
                    .cornerRadius(10)
            }
            
            if stop.type == .stop && stops.count > 3 {
                Button(action: {
                    let idx: Int = index
                    withAnimation(.spring()) {
                        let _ = stops.remove(at: idx)
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red.opacity(0.6))
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    // MARK: - Suggested Stops
    private var suggestedSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Add")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(suggestedStops, id: \.self) { stop in
                        Button(action: {
                            if let idx = stops.firstIndex(where: { $0.name.isEmpty }) {
                                withAnimation { stops[idx].name = stop }
                            }
                        }) {
                            HStack(spacing: 6) {
                                Image(systemName: "mappin.circle.fill")
                                    .font(.caption2)
                                Text(stop)
                                    .font(.caption)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.08))
                            .foregroundColor(.black)
                            .cornerRadius(20)
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - Vehicle Selection
    private var vehicleSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Vehicle")
                .font(.headline)
            
            HStack(spacing: 12) {
                ForEach(["Auto", "Cab"], id: \.self) { vehicle in
                    Button(action: {
                        withAnimation { selectedVehicle = vehicle }
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: vehicle == "Auto" ? "car.2.fill" : "car.fill")
                            Text(vehicle)
                                .fontWeight(.medium)
                        }
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                        .padding(14)
                        .background(selectedVehicle == vehicle ? brandYellow.opacity(0.15) : Color.gray.opacity(0.06))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(selectedVehicle == vehicle ? brandYellow : Color.clear, lineWidth: 2)
                        )
                        .cornerRadius(12)
                    }
                    .foregroundColor(.black)
                }
            }
            
            Text("Multi-stop is available for Auto & Cab only")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(16)
        .padding(.horizontal)
    }
    
    // MARK: - Estimate Button
    private var estimateButton: some View {
        Button(action: {
            withAnimation(.spring()) {
                estimatedFare = selectedVehicle == "Auto" ? Int.random(in: 120...200) : Int.random(in: 280...450)
                estimatedTime = Int.random(in: 25...50)
                showEstimate = true
            }
        }) {
            HStack {
                Image(systemName: "calculator")
                Text("Get Fare Estimate")
                    .fontWeight(.bold)
            }
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .padding()
            .background(brandYellow)
            .cornerRadius(14)
        }
        .padding(.horizontal)
    }
    
    // MARK: - Estimate Result
    private var estimateResultSection: some View {
        let filledStops = stops.filter { !$0.name.isEmpty }
        
        return VStack(spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Estimated Fare")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("₹\(estimatedFare)")
                        .font(.title)
                        .fontWeight(.black)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Estimated Time")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("~\(estimatedTime) min")
                        .font(.title3)
                        .fontWeight(.bold)
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Route Plan")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                ForEach(Array(filledStops.enumerated()), id: \.element.id) { index, stop in
                    HStack(spacing: 10) {
                        Text("\(index + 1)")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 22, height: 22)
                            .background(stopColor(for: stop.type))
                            .clipShape(Circle())
                        
                        Text(stop.name)
                            .font(.caption)
                        
                        Spacer()
                        
                        if index < filledStops.count - 1 {
                            Text("5 min wait")
                                .font(.caption2)
                                .foregroundColor(.orange)
                        }
                    }
                }
            }
            
            Button(action: {}) {
                Text("Book Multi-Stop Ride")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(12)
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(16)
        .padding(.horizontal)
        .transition(.opacity.combined(with: .move(edge: .bottom)))
    }
    
    func stopColor(for type: StopType) -> Color {
        switch type {
        case .pickup: return .green
        case .stop: return .orange
        case .dropoff: return .red
        }
    }
    
    func stopLabel(for type: StopType, index: Int) -> String {
        switch type {
        case .pickup: return "PICKUP"
        case .stop: return "STOP \(index)"
        case .dropoff: return "DROP OFF"
        }
    }
}




struct RideStop: Identifiable {
    let id = UUID()
    var name: String
    let type: StopType
}

enum StopType {
    case pickup, stop, dropoff
}
