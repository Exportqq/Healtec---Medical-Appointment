import UIKit

class CustomDeleteBtnView: UIView {
    
    private let customBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 18)
        button.backgroundColor = .customRed
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstrains()
    }
    
    private var nextPageAction: (() -> Void)?

    @objc private func getNextPage() {
        nextPageAction?()
    }

    func configure(title: String, nextPage: @escaping () -> Void) {
        customBtn.setTitle(title, for: .normal)
        nextPageAction = nextPage
        customBtn.addTarget(self, action: #selector(getNextPage), for: .touchUpInside)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(customBtn)
    }
    
    
    private func setupConstrains() {
        [customBtn].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            customBtn.topAnchor.constraint(equalTo: self.topAnchor),
            customBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            customBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            customBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            customBtn.heightAnchor.constraint(equalToConstant: 60),

        ])
    }
}

