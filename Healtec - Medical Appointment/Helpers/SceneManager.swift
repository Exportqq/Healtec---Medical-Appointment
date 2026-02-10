import UIKit

final class SceneManager {

    static let shared = SceneManager()
    private init() {}

    func showAuth() {
        let scene = UIApplication.shared.connectedScenes
            .first { $0.activationState == .foregroundActive } as! UIWindowScene
        let window = scene.windows.first!

        let nav = UINavigationController(rootViewController: Auth())
        nav.navigationBar.isHidden = true

        window.rootViewController = nav
        window.makeKeyAndVisible()
    }

    func showMain() {
        let scene = UIApplication.shared.connectedScenes
            .first { $0.activationState == .foregroundActive } as! UIWindowScene
        let window = scene.windows.first!

        let nav = UINavigationController(rootViewController: MainTabBarController())
        nav.navigationBar.isHidden = true

        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}
