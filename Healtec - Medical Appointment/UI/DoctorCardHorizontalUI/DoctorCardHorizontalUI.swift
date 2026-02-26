import UIKit

class DoctorCardHorizontalUIView: UIView {
    
    let doctorInfoView: UIView = {
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
    
    let doctorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    let doctorInfo = DoctorInfoHorizontalView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(doctorInfoView)
        doctorInfoView.addSubview(doctorImageView)
    }
    
    private func setupConstrains() {
        [doctorInfoView, doctorImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            doctorInfoView.topAnchor.constraint(equalTo: self.bottomAnchor),
            doctorInfoView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            doctorInfoView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            doctorInfoView.heightAnchor.constraint(equalToConstant: 108),
            
            doctorImageView.centerYAnchor.constraint(equalTo: doctorInfoView.centerYAnchor),
            doctorImageView.leadingAnchor.constraint(equalTo: doctorInfoView.leadingAnchor, constant: 8),
            doctorImageView.heightAnchor.constraint(equalToConstant: 92),
            doctorImageView.widthAnchor.constraint(equalToConstant: 92),
            
            doctorInfo.centerYAnchor.constraint(equalTo: doctorInfoView.centerYAnchor),
            doctorInfo.trailingAnchor.constraint(equalTo: doctorInfoView.trailingAnchor, constant: -8)
        ])
    }

}

