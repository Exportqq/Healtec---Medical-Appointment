final class AuthService {

    static let shared = AuthService()
    private init() {}
    
    private let baseURL = "https://healtec.onrender.com"

    // MARK: - Регистрация
    func register(username: String, password: String, repeatPassword: String) async throws -> AuthResponse {
        let body = RegisterRequest(username: username, password: password, repeat_password: repeatPassword)
        return try await ApiClient.shared.request(
            "\(baseURL)/auth/register",
            method: .POST,
            body: body
        )
    }

    // MARK: - Логин
    func login(username: String, password: String) async throws -> AuthResponse {
        let body = LoginRequest(username: username, password: password)
        return try await ApiClient.shared.request(
            "\(baseURL)/auth/login",
            method: .POST,
            body: body
        )
    }
    
    // MARK: - Профиль
    func getProfile(token: String) async throws -> UserProfile {
        return try await ApiClient.shared.request(
            "\(baseURL)/me",
            method: .GET,
            body: nil,
            token: token
        )
    }
}
