import Foundation

struct LoginResponse: Codable {
    let success: Bool
    let user: User
}
