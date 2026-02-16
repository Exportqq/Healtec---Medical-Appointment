import UIKit

class ProfileItemsMainView: UIView {
    
    private let profileMainImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "profile")
        return img
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
        addSubview(profileMainImage)
    }
    
    private func setupConstrains() {
        [profileMainImage].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            profileMainImage.topAnchor.constraint(equalTo: topAnchor),
            profileMainImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileMainImage.heightAnchor.constraint(equalToConstant: 48),
            profileMainImage.widthAnchor.constraint(equalToConstant: 48)
        ])
    }
}

