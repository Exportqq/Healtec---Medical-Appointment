import UIKit

class ProfileMainView: UIView {
    
    private let backgorund: UIView = {
        let view = UIView()
        view.backgroundColor = .borderClr
        view.clipsToBounds = true
        return view
    }()
    
    private let backgroundTexture: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profileTexture")
        return imageView
    }()
    
    private let profileItemsMain = ProfileItemsMainView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        
        loadProfile()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(backgorund)
        backgorund.addSubview(backgroundTexture)
        backgorund.addSubview(profileItemsMain)
    }
    
    private func loadProfile() {
        Task {
            do {
                let profile = try await AuthService.shared.getProfile()
                await MainActor.run {
                    self.profileItemsMain.configure(username: profile.username)
                }
            } catch {
                print("Ошибка загрузки профиля:", error)
            }
        }
    }
    
    private func setupConstraints() {
        [backgorund, backgroundTexture].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            backgorund.topAnchor.constraint(equalTo: topAnchor),
            backgorund.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgorund.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgorund.heightAnchor.constraint(equalToConstant: 220),
            
            profileItemsMain.topAnchor.constraint(equalTo: backgorund.topAnchor),
            profileItemsMain.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            backgroundTexture.topAnchor.constraint(equalTo: backgorund.topAnchor),
            backgroundTexture.centerXAnchor.constraint(equalTo: backgorund.centerXAnchor),
            
        ])
    }
}
