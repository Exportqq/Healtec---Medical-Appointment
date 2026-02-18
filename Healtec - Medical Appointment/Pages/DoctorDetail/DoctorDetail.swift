import UIKit

class DoctorDetail: UIViewController {
    private let doctorInfo = DoctorInfoDetail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        SetupConstraints()
    }
    
    private func SetupView() {
        view.backgroundColor = .white
        view.addSubview(doctorInfo)
    }
    
    func configure(image: UIImage?, name: String ) {
        doctorInfo.docImage.image = image
        doctorInfo.docName.text = name
    }
    
    private func SetupConstraints() {
        doctorInfo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            doctorInfo.topAnchor.constraint(equalTo: view.topAnchor),
            doctorInfo.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            doctorInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            doctorInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

