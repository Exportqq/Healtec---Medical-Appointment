import UIKit

class ProfileItems: UIView {
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let profileName: UILabel = {
        let label = UILabel()
        label.text = "John Doe"
        label.font = UIFont(name: "Inter-SemiBold", size: 20)
        return label
    }()
    
    private lazy var profileStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [profileImage, profileName])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fill
        stack.alignment = .center
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(profileStack)
    }
    
    private func setupConstrains() {
        [profileStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            profileStack.topAnchor.constraint(equalTo: self.topAnchor),
            profileStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            profileStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            profileStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            
            profileImage.heightAnchor.constraint(equalToConstant: 121),
            profileImage.heightAnchor.constraint(equalToConstant: 121)
        ])
    }
}

