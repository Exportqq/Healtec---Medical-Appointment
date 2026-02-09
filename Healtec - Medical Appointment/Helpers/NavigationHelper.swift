import UIKit

enum NavigationHelper {

    static func push(
        from viewController: UIViewController?,
        to destination: UIViewController,
        animated: Bool = true
    ) {
        viewController?.navigationController?.pushViewController(destination, animated: animated)
    }
}
