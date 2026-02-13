import UIKit

class DoctorInfoView: UIView {
    
    let doctorName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Medium", size: 14)
        lbl.textColor = .textBlack
        return lbl
    }()
    
    let doctorSpeciality: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Light", size: 12)
        lbl.textColor = .textGrey
        return lbl
    }()
    
    private let starIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "star")
        return img
    }()
    
    let doctorRaiting: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Medium", size: 10)
        lbl.textColor = .textBlack
        return lbl
    }()
    
    
    private lazy var doctorNameStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [doctorName, doctorSpeciality])
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fill
        stack.alignment = .leading
        return stack
    }()
    
    private lazy var doctorRaitingStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [starIcon, doctorRaiting])
        stack.axis = .horizontal
        stack.spacing = 4
        stack.distribution = .fill
        stack.alignment = .center
        return stack
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [doctorNameStack, doctorRaitingStack])
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .equalSpacing
        stack.alignment = .top
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
    
    func configure(name: String, speciality: String, raiting: Double) {
        doctorName.text = name
        doctorSpeciality.text = speciality
        doctorRaiting.text = "\(raiting)"
    }
    
    private func setupUI() {
        addSubview(mainStack)
    }
    
    private func setupConstrains() {
        [mainStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            mainStack.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])


    }
}

