import UIKit

class ProfileItemsMainView: UIView {
    
    private let profileMainImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "profile")
        return img
    }()
    
    private let profileMainWelcome: UILabel = {
        let lbl = UILabel()
        lbl.text = "Hello, Welcome  🎉"
        lbl.font = UIFont(name: "Inter-Regular", size: 14)
        return lbl
    }()
    
    private let profileMainName: UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-SemiBold", size: 20)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstrains()
    }
    
    func configure(username: String) {
        profileMainName.text = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(profileMainImage)
        addSubview(profileMainWelcome)
        addSubview(profileMainName)
    }
    
    private func setupConstrains() {
        [profileMainImage, profileMainWelcome, profileMainName].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            profileMainImage.topAnchor.constraint(equalTo: topAnchor, constant: 70),
            profileMainImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            profileMainImage.heightAnchor.constraint(equalToConstant: 48),
            profileMainImage.widthAnchor.constraint(equalToConstant: 48),
            
            profileMainWelcome.topAnchor.constraint(equalTo: profileMainImage.topAnchor),
            profileMainWelcome.leadingAnchor.constraint(equalTo: profileMainImage.trailingAnchor, constant: 16),
            
            profileMainName.topAnchor.constraint(equalTo: profileMainWelcome.bottomAnchor, constant: 4),
            profileMainName.leadingAnchor.constraint(equalTo: profileMainWelcome.leadingAnchor),
            profileMainName.heightAnchor.constraint(equalToConstant: 30)

        ])
    }
}

