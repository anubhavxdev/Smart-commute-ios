import Foundation

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
}
