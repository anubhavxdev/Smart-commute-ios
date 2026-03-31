import Foundation

struct User: Identifiable, Codable, Sendable {
    let id: String
    let name: String
    let email: String
}
