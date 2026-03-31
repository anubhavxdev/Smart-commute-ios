import Foundation

class AuthService {
    init() {}
    
    func login(email: String, password: String) async throws -> User {
        let endpoint = "http://localhost:3000/login"
        guard let url = URL(string: endpoint) else {
            throw AuthError.invalidURL
        }
        
        let loginData = ["email": email, "password": password]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: loginData, options: [])
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, 
              (200...299).contains(httpResponse.statusCode) else {
            throw AuthError.serverError
        }
        
        do {
            let decoder = JSONDecoder()
            let loginResponse = try decoder.decode(LoginResponse.self, from: data)
            return loginResponse.user
        } catch {
            throw AuthError.decodingError
        }
    }
}

enum AuthError: LocalizedError {
    case invalidURL
    case serverError
    case decodingError
    case fieldsEmpty
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "The URL is invalid."
        case .serverError: return "There was an error communicating with the server."
        case .decodingError: return "Failed to process server response."
        case .fieldsEmpty: return "Email and password cannot be empty."
        }
    }
}
