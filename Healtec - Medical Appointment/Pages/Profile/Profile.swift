import UIKit

class ProfileVC: UIViewController {
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
    
    let profileItems = ProfileItemsView()
    
    let logoutBtn = CustomDeleteBtnView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        SetupConstraints()
        
        loadProfile()
    }
    
    private func loadProfile() {
        Task {
            do {
                let profile = try await AuthService.shared.getProfile()
                await MainActor.run {
                    self.profileItems.configure(username: profile.username)
                }
            } catch {
                print("Ошибка загрузки профиля:", error)
                SessionManager.shared.logout()
                NavigationHelper.push(AuthVC(), from: self)
            }
        }
    }
    
    private func SetupView() {
        view.backgroundColor = .white
        view.addSubview(backgorund)
        backgorund.addSubview(backgroundTexture)
        backgorund.addSubview(profileItems)
        view.addSubview(logoutBtn)
        
        logoutBtn.configure(title: "Logout") { [weak self] in
            guard let self else { return }
            
            AuthService.shared.logout()
            NavigationHelper.push(AuthVC(), from: self)
        }
    }
    
    deinit {
        print("Profile closed")
    }
    
    private func SetupConstraints() {
        [backgorund, backgroundTexture, profileItems, logoutBtn].forEach{
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
            profileItems.centerYAnchor.constraint(equalTo: backgorund.safeAreaLayoutGuide.centerYAnchor),
            
            logoutBtn.topAnchor.constraint(equalTo: backgorund.bottomAnchor, constant: 14),
            logoutBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            logoutBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
    }
}
