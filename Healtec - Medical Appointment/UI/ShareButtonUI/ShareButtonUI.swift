import UIKit

class ShareButtonUI: UIButton {

    var shareText: String?
    var shareURL: URL?

    init(text: String = "Share", icon: UIImage? = UIImage(systemName: "square.and.arrow.up")) {
        super.init(frame: .zero)
        setupButton(text: text, icon: icon)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton(text: "Share", icon: UIImage(systemName: "square.and.arrow.up"))
    }

    private func setupButton(text: String, icon: UIImage?) {
        setTitle(" \(text)", for: .normal)
        setImage(icon, for: .normal)
        tintColor = .white
        backgroundColor = UIColor.systemBlue
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        translatesAutoresizingMaskIntoConstraints = false

        addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
    }

    @objc private func shareTapped() {
        guard let text = shareText, let url = shareURL else {
            print("Share content not set!")
            return
        }

        let items: [Any] = [text, url]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)

        if let popoverController = activityVC.popoverPresentationController {
            popoverController.sourceView = self
            popoverController.sourceRect = self.bounds
            popoverController.permittedArrowDirections = []
        }

        if let topVC = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController {
            topVC.present(activityVC, animated: true)
        }
    }
}
