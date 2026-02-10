import UIKit

enum NavigationHelper {

    static func push(
        _ viewController: UIViewController,
        from current: UIViewController,
        animated: Bool = true
    ) {
        current.navigationController?.pushViewController(
            viewController,
            animated: animated
        )
    }

    static func pop(
        from current: UIViewController,
        animated: Bool = true
    ) {
        current.navigationController?.popViewController(animated: animated)
    }

    static func popToRoot(
        from current: UIViewController,
        animated: Bool = true
    ) {
        current.navigationController?.popToRootViewController(animated: animated)
    }
}
