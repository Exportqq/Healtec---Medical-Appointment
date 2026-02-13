import UIKit

class DoctorCardUIView: UIView {
    
    let doctorImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "docc")
        img.contentMode = .scaleAspectFill
        return img
    }()
    
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
    
    let doctorInfo = DoctorInfoView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(doctorImage)
        addSubview(doctorInfoView)
        doctorInfoView.addSubview(doctorInfo)
    }
    
    private func setupConstrains() {
        [doctorImage, doctorInfoView, doctorInfo].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            doctorImage.topAnchor.constraint(equalTo: self.topAnchor),
            doctorImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            doctorImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            doctorImage.heightAnchor.constraint(equalToConstant: 134),
            
            doctorInfoView.topAnchor.constraint(equalTo: doctorImage.bottomAnchor),
            doctorInfoView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            doctorInfoView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            doctorInfoView.heightAnchor.constraint(equalToConstant: 59),
            
            doctorInfo.topAnchor.constraint(equalTo: doctorInfoView.topAnchor),
            doctorInfo.leadingAnchor.constraint(equalTo: doctorInfoView.leadingAnchor),
            doctorInfo.trailingAnchor.constraint(equalTo: doctorInfoView.trailingAnchor),
            doctorInfo.bottomAnchor.constraint(equalTo: doctorInfoView.bottomAnchor),
        ])
    }

}

