import Foundation

struct Driver: Identifiable, Codable {
    let id: String
    let name: String
    let rating: Double
    let vehicleModel: String
    let plateNumber: String
    let phoneNumber: String
    let vehicleType: VehicleType
}

enum VehicleType: String, Codable {
    case bike = "Bike"
    case auto = "Auto"
    case cab = "Cab"
    case parcel = "Parcel"
}
