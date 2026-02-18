import UIKit

class DoctorInfoDetail: UIView {
    
    let docImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private let doctorInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor(red: 151/255, green: 151/255, blue: 150/255, alpha: 1).cgColor
        view.layer.shadowOpacity = 0.14
        view.layer.shadowOffset = CGSize(width: 0, height: -5)
        view.layer.shadowRadius = 15
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    let docName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-SemiBold", size: 16)
        lbl.textColor = .textBlack
        return lbl
    }()
    
    let docSpeciality: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Ligth", size: 12)
        lbl.textColor = .textGrey
        return lbl
    }()
    
    private let starIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "star")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let docRaiting: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Inter-Medium", size: 12)
        lbl.textColor = .textBlack
        return lbl
    }()
    
    private lazy var stackRating: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [starIcon, docRaiting])
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    private lazy var stackInfo: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [docName, docSpeciality])
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    private lazy var stackMain: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [stackInfo, stackRating])
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .equalSpacing
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
        addSubview(docImage)
        addSubview(doctorInfoView)
        doctorInfoView.addSubview(stackMain)
    }

    
    private func setupConstrains() {
        [docImage, doctorInfoView, stackMain].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            docImage.topAnchor.constraint(equalTo: self.topAnchor),
            docImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            docImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            docImage.heightAnchor.constraint(equalToConstant: 247),
            
            doctorInfoView.topAnchor.constraint(equalTo: docImage.bottomAnchor),
            doctorInfoView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            doctorInfoView.heightAnchor.constraint(equalToConstant: 82),
            
            stackMain.centerYAnchor.constraint(equalTo: doctorInfoView.centerYAnchor),
            stackMain.centerXAnchor.constraint(equalTo: doctorInfoView.centerXAnchor)
        ])
    }
}

