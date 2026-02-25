import UIKit

class DoctorDetail: UIViewController {
    private let doctorInfo = DoctorInfoDetail()
    
    private let doctorStats = DoctorStatsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        SetupConstraints()
    }
    
    private func SetupView() {
        view.backgroundColor = .white
        view.addSubview(doctorInfo)
        view.addSubview(doctorStats)
    }
    
    func configure(image: UIImage?, name: String, speciality: String, raiting: Double, reviews: String, iconStats: String, valueStats: String, titleStats: String) {
        doctorInfo.docImage.image = image
        doctorInfo.docName.text = name
        doctorInfo.docSpeciality.text = speciality
        doctorInfo.docRaiting.text = "\(raiting) (\(reviews) reviews)"
        
        doctorStats.patients.configure(icon: iconStats, value: valueStats, title: titleStats)
    }

    private func SetupConstraints() {
        [doctorInfo, doctorStats].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        NSLayoutConstraint.activate([
            doctorInfo.topAnchor.constraint(equalTo: view.topAnchor),
            doctorInfo.heightAnchor.constraint(equalToConstant: 329),
            doctorInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            doctorInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            doctorStats.topAnchor.constraint(equalTo: doctorInfo.bottomAnchor, constant: 27),
            doctorStats.heightAnchor.constraint(equalToConstant: 94),
            doctorStats.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            doctorStats.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

