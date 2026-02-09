import UIKit

class Profile: UIViewController {
    private let backgorund: UIView = {
        let view = UIView()
        view.backgroundColor = .borderClr
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner
        ]
        view.clipsToBounds = true
        return view
    }()
    
    private let backgroundTexture: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profileTexture")
        return imageView
    }()
    
    let profileItems = ProfileItems()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        SetupConstraints()
        
        teleportLogin(token: AuthService.shared.getProfile(token: token))
    }
    
    private func SetupView() {
        view.backgroundColor = .white
        
        view.addSubview(backgorund)
        backgorund.addSubview(backgroundTexture)
        backgorund.addSubview(profileItems)
    }
    
    func teleportLogin(token: String) {
        if token.isEmpty {
            NavigationHelper.push(from: self, to: Auth())
        }
    }

    
    private func SetupConstraints() {
        [backgorund, backgroundTexture, profileItems].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            backgorund.topAnchor.constraint(equalTo: view.topAnchor),
            backgorund.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgorund.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgorund.heightAnchor.constraint(equalToConstant: 300),
            
            backgroundTexture.topAnchor.constraint(equalTo: backgorund.topAnchor),
            backgroundTexture.centerXAnchor.constraint(equalTo: backgorund.centerXAnchor),
            
            profileItems.centerXAnchor.constraint(equalTo: backgorund.centerXAnchor),
            profileItems.centerYAnchor.constraint(equalTo: backgorund.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}
