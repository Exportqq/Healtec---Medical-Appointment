import Foundation

final class AuthService {

    static let shared = AuthService()
    private init() {}

    private let baseURL = "https://healtec.onrender.com"

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
            method: .post,
            body: body
        )

        KeychainService.shared.saveToken(response.token)
        return response
    }

    func login(username: String, password: String) async throws -> AuthResponse {

        let body = LoginRequest(username: username, password: password)

        let response: AuthResponse = try await ApiClient.shared.request(
            "\(baseURL)/auth/login",
            method: .post,
            body: body
        )

        KeychainService.shared.saveToken(response.token)
        return response
    }

    func getProfile() async throws -> UserProfile {
        guard let token = KeychainService.shared.getToken() else {
            throw URLError(.userAuthenticationRequired)
        }

        return try await ApiClient.shared.request(
            "\(baseURL)/me",
            method: .get,
            body: nil,
            token: token
        )
    }

    func logout() {
        KeychainService.shared.deleteToken()
    }
}
