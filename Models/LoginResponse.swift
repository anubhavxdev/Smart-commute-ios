import Foundation

struct LoginResponse: Codable, Sendable {
    let success: Bool
    let user: User
}
