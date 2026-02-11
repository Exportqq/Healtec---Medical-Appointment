import UIKit

class CustomBtnView: UIView {
    
    private let CustomBtn: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .borderClr
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
        CustomBtn.setTitle(title, for: .normal)
        nextPageAction = nextPage
        CustomBtn.addTarget(self, action: #selector(getNextPage), for: .touchUpInside)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(CustomBtn)
    }
    
    
    private func setupConstrains() {
        [CustomBtn].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            CustomBtn.topAnchor.constraint(equalTo: self.topAnchor),
            CustomBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            CustomBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            CustomBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            CustomBtn.heightAnchor.constraint(equalToConstant: 60),

        ])
    }
}

