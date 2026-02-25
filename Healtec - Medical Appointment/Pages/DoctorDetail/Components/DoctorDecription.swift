import UIKit

class DoctorDecriptionView: UIView {
    
    private let infoTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Medium", size: 16)
        lbl.textColor = .textBlack
        lbl.text = "About Me"
        return lbl
    }()
    
    let infoTxt: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Light", size: 12)
        lbl.textColor = .textGrey
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [infoTitle, infoTxt])
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    func configure(decription: String) {
        infoTxt.text = decription
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(mainStack)
    }
    
    private func setupConstrains() {
        [mainStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: self.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

