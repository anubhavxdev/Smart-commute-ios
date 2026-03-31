import Foundation

struct Ride: Identifiable, Codable {
    let id: String
    let destination: String
    let pickupLocation: String
    let time: Date
    let driverName: String
    let status: RideStatus
}

enum RideStatus: String, Codable {
    case upcoming = "Upcoming"
    case completed = "Completed"
    case cancelled = "Cancelled"
}
