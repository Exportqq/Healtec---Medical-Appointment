import Foundation

final class TokenStorage {

    static let shared = TokenStorage()
    private init() {}

    private let key = "access_token"

    var token: String? {
        get {
            UserDefaults.standard.string(forKey: key)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
}
