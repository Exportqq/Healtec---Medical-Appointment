import UIKit

class DoctorStatsView: UIView {
    
    let patients = StatItemViewUI()
    let exp = StatItemViewUI()
    let rating = StatItemViewUI()
    let reviews = StatItemViewUI()
    
    private lazy var stackInfo: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [patients, exp, rating, reviews])
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillEqually
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
        addSubview(stackInfo)
    }
    
    func configure(icon: String, value: String, title: String) {
            patients.configure(
                icon: icon,
                value: value,
                title: title
            )
        
            exp.configure(
                icon: icon,
                value: value,
                title: title
            )
            
            rating.configure(
                icon: icon,
                value: value,
                title: title
            )
            
            reviews.configure(
                icon: icon,
                value: value,
                title: title
            )
        }
    
    
    
    private func setupConstrains() {
        [stackInfo] .forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            stackInfo.topAnchor.constraint(equalTo: self.topAnchor),
            stackInfo.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackInfo.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackInfo.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

