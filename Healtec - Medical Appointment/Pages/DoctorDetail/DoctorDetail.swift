import UIKit
import Kingfisher

class DoctorDetail: UIViewController {
    private var doctorInfo = DoctorInfoDetail()
    
    private let doctorStats = DoctorStatsView()
    
    private let doctorDecription = DoctorDecriptionView()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [doctorInfo, doctorStats, doctorDecription])
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        SetupConstraints()
        
        title = "Doctor"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func SetupView() {
        view.backgroundColor = .white
        view.addSubview(mainStackView)
    
    }
    
    func configure( image: UIImage?, name: String, speciality: String, raiting: Double, reviews: String, patientsCount: String, experience: String, description: String
    ) {
        
        
        doctorInfo.docImage.image = image
        doctorInfo.docName.text = name
        doctorInfo.docSpeciality.text = speciality
        doctorInfo.docRaiting.text = "\(raiting) (\(reviews) reviews)"
        doctorDecription.infoTxt.text = description
        
        doctorStats.patients.configure(
            icon: "patients",
            value: patientsCount,
            title: "Patients"
        )
        
        doctorStats.exp.configure(
            icon: "exp",
            value: experience,
            title: "Years Exp"
        )
        
        doctorStats.rating.configure(
            icon: "rating",
            value: "\(raiting)",
            title: "Rating"
        )
        
        doctorStats.reviews.configure(
            icon: "reviews",
            value: reviews,
            title: "Reviews"
        )
    }

    private func SetupConstraints() {
        [mainStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        NSLayoutConstraint.activate([
            doctorInfo.heightAnchor.constraint(equalToConstant: 329),
            doctorStats.heightAnchor.constraint(equalToConstant: 94),
            doctorDecription.heightAnchor.constraint(equalToConstant: 68),

            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 59),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
        ])
    }
}

