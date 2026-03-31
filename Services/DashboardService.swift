import Foundation

class DashboardService: Sendable {
    nonisolated func fetchRides() async throws -> [Ride] {
        let endpoint = "http://localhost:3000/rides"
        guard let url = URL(string: endpoint) else {
            throw NSError(domain: "InvalidURL", code: 0, userInfo: nil)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, 
                  (200...299).contains(httpResponse.statusCode) else {
                throw NSError(domain: "ServerError", code: 1, userInfo: nil)
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let rides = try decoder.decode([Ride].self, from: data)
            return rides
        } catch {
            print("Server not available, using mock rides: \(error.localizedDescription)")
            let now = Date()
            return [
                Ride(id: "ride_001", destination: "Koramangala 5th Block", pickupLocation: "HSR Layout", time: now.addingTimeInterval(-3600), driverName: "Raju Kumar", status: .completed),
                Ride(id: "ride_002", destination: "Indiranagar Metro", pickupLocation: "Koramangala", time: now.addingTimeInterval(-86400), driverName: "Suresh", status: .completed),
                Ride(id: "ride_003", destination: "Airport T2", pickupLocation: "Indiranagar", time: now.addingTimeInterval(-172800), driverName: "Vikram", status: .completed),
                Ride(id: "ride_004", destination: "MG Road", pickupLocation: "BTM Layout", time: now.addingTimeInterval(-259200), driverName: "Arjun", status: .completed),
                Ride(id: "ride_005", destination: "Electronic City", pickupLocation: "Silk Board", time: now.addingTimeInterval(-345600), driverName: "Mohan", status: .completed),
            ]
        }
    }
}
