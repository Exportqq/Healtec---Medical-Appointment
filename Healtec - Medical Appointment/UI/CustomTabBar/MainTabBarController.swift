import UIKit

final class MainTabBarController: UITabBarController {

    private let customTabBar = CustomTabBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.isHidden = true
        setupTabs()
        setupCustomTabBar()
    }

    private func setupTabs() {
        let catalog = Main()
        let profile = Profile()

        viewControllers = [
            catalog,
            profile
        ]
    }

    private func setupCustomTabBar() {
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customTabBar)

        NSLayoutConstraint.activate([
            customTabBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            customTabBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            customTabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            customTabBar.heightAnchor.constraint(equalToConstant: 70)
        ])

        customTabBar.onSelect = { [weak self] index in
            self?.selectedIndex = index
        }
    }
}

