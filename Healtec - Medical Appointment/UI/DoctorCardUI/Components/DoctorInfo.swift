import UIKit

class DoctorInfo: UIView {
    
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
    
    private lazy var doctorInfoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [doctorNameStack, doctorRaitingStack])
        stack.axis = .horizontal
        stack.spacing = 0
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
        addSubview(doctorInfoStack)
    }
    
    private func setupConstrains() {
        [doctorInfoStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            starIcon.heightAnchor.constraint(equalToConstant: 16),
            starIcon.widthAnchor.constraint(equalToConstant: 16),
            
            doctorNameStack.widthAnchor.constraint(equalToConstant: 81),
            doctorRaitingStack.widthAnchor.constraint(equalToConstant: 44),
            
            doctorInfoStack.topAnchor.constraint(equalTo: self.topAnchor),
            doctorInfoStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            doctorInfoStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])

    }
}

