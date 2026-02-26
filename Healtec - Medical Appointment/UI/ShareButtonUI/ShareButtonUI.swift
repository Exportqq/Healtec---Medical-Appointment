import UIKit

class ShareButtonUI: UIButton {

    var shareText: String?
    var shareURL: URL?

    init(text: String = "Share",
         icon: UIImage? = UIImage(systemName: "square.and.arrow.up")) {
        super.init(frame: .zero)
        setupButton(text: text, icon: icon)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton(text: "Share",
                    icon: UIImage(systemName: "square.and.arrow.up"))
    }

    private func setupButton(text: String, icon: UIImage?) {
        var config = UIButton.Configuration.filled()
        config.title = text
        config.image = icon
        config.imagePadding = 8                 
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .borderClr
        config.cornerStyle = .fixed
        config.background.cornerRadius = 14

        configuration = config

        titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 16)
        translatesAutoresizingMaskIntoConstraints = false

        addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
    }

    @objc private func shareTapped() {
        guard let text = shareText, let url = shareURL else {
            print("Share content not set!")
            return
        }

        let items: [Any] = [text, url]
        let activityVC = UIActivityViewController(activityItems: items,
                                                  applicationActivities: nil)

        if let popoverController = activityVC.popoverPresentationController {
            popoverController.sourceView = self
            popoverController.sourceRect = self.bounds
            popoverController.permittedArrowDirections = []
        }

        if let topVC = UIApplication.shared
            .connectedScenes
            .compactMap({ ($0 as? UIWindowScene)?.keyWindow })
            .first?.rootViewController {
            topVC.present(activityVC, animated: true)
        }
    }
}
