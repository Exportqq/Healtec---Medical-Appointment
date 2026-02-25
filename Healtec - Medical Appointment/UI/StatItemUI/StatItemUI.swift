import UIKit

final class StatItemViewUI: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blurClr
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let iconView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private let valueLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Medium", size: 16)
        lbl.textColor = .textBlack
        return lbl
    }()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Light", size: 12)
        lbl.textColor = .textGrey
        lbl.textAlignment = .center
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(icon: String, value: String, title: String) {
        iconView.image = UIImage(named: icon)
        valueLabel.text = value
        titleLabel.text = title
    }
    
    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(iconView)
        addSubview(valueLabel)
        addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        [containerView, iconView, valueLabel, titleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 40),
            containerView.heightAnchor.constraint(equalToConstant: 40),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            iconView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            
            valueLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 8),
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 2),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
