import Foundation

class DashboardService {
    func fetchRides() async throws -> [Ride] {
        let endpoint = "http://localhost:3000/rides"
        guard let url = URL(string: endpoint) else {
            throw NSError(domain: "InvalidURL", code: 0, userInfo: nil)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, 
              (200...299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "ServerError", code: 1, userInfo: nil)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let rides = try decoder.decode([Ride].self, from: data)
            return rides
        } catch {
            print("Decoding Error:", error)
            throw NSError(domain: "DecodingError", code: 2, userInfo: nil)
        }
    }
}
