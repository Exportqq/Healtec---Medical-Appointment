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
    
    func configure(image: UIImage?, name: String, speciality: String, raiting: String, reviews: String) {
        doctorInfo.docImage.image = image
        doctorInfo.docName.text = name
        doctorInfo.docSpeciality.text = speciality
        doctorInfo.docRaiting.text = "\(raiting) + ' ' \(reviews) + 'reviews'"
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

