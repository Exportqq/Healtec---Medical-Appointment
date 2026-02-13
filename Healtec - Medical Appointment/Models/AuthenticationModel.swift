import Foundation

struct RegisterRequest: Encodable {
    let username: String
    let password: String
    let repeat_password: String
}

struct LoginRequest: Encodable {
    let username: String
    let password: String
}

struct UserProfile: Decodable {
    let id: Int
    let username: String
}

struct AuthResponse: Decodable {
    let token: String
    let username: String
}


