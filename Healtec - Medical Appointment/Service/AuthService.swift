import Foundation

final class AuthService {

    static let shared = AuthService()
    private init() {}

    private let baseURL = "https://healtec.onrender.com"

    // MARK: - Register
    func register(
        username: String,
        password: String,
        repeatPassword: String
    ) async throws -> AuthResponse {

        let body = RegisterRequest(
            username: username,
            password: password,
            repeat_password: repeatPassword
        )

        let response: AuthResponse = try await ApiClient.shared.request(
            "\(baseURL)/auth/register",
            method: .POST,
            body: body
        )

        KeychainService.shared.saveToken(response.token)
        return response
    }

    // MARK: - Login
    func login(username: String, password: String) async throws -> AuthResponse {

        let body = LoginRequest(username: username, password: password)

        let response: AuthResponse = try await ApiClient.shared.request(
            "\(baseURL)/auth/login",
            method: .POST,
            body: body
        )

        KeychainService.shared.saveToken(response.token)
        return response
    }

    // MARK: - Profile
    func getProfile() async throws -> UserProfile {
        guard let token = KeychainService.shared.getToken() else {
            throw URLError(.userAuthenticationRequired)
        }

        return try await ApiClient.shared.request(
            "\(baseURL)/me",
            method: .GET,
            body: nil,
            token: token
        )
    }

    // MARK: - Logout
    func logout() {
        KeychainService.shared.deleteToken()
    }
}
