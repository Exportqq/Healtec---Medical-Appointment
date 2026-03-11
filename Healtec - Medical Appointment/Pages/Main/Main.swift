import UIKit

class FavoriteDoctors: UIViewController {
    
    private let profileMain = ProfileMainView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorite Doctors"
        label.font = UIFont(name: "Inter-Medium", size: 16)
        label.textColor = .textBlack
        return label
    }()
    
    private let seeAllBtn: UIButton = {
        let button = UIButton()
        button.setTitle("See All", for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Regular", size: 14)
        button.setTitleColor(.borderClr, for: .normal)
        return button
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, seeAllBtn])
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.alignment = .top
        return stack
    }()
    
    private let titleTopDoctors: UILabel = {
        let label = UILabel()
        label.text = "Top Doctors"
        label.font = UIFont(name: "Inter-Medium", size: 16)
        label.textColor = .textBlack
        return label
    }()
    
    private let doctors = DoctorsListFavouriteCV()
    
    private let topDoctors = TopDoctorsCV()
    
    private let filters = Filters()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        SetupConstraints()
        setupActions()
        setupDoctorSelection()
        
        filters.onFilterSelected = { [weak self] filter in
            self?.doctors.filterDoctors(by: filter)
        }
        
        profileMain.output = self
    }
    
    private func SetupView() {
        view.backgroundColor = .white

        
        view.addSubview(mainStack)
        view.addSubview(filters)
        view.addSubview(titleTopDoctors)
        view.addSubview(doctors)
        view.addSubview(topDoctors)
        view.addSubview(profileMain)
    }
    
    @objc private func allDoctors() {
        NavigationHelper.present(
            DoctorsListViewController(),
            from: self,
            style: .pageSheet
        )
    }
    
    private func setupDoctorSelection() {
        doctors.onDoctorSelected = { [weak self] doctor in
            guard let self = self else { return }

            let vc = DoctorDetail()
            
            vc.configure(
                image: doctor.image,
                name: doctor.name,
                speciality: doctor.specialty,
                raiting: doctor.rating,
                reviews: doctor.reviewsCount,
                patientsCount: doctor.patientsCount,
                experience: doctor.experience,
                description: doctor.description
            )
            
            NavigationHelper.push(vc, from: self)
        }
        
        topDoctors.onDoctorSelected = { [weak self] doctor in
            guard let self = self else { return }

            let vc = DoctorDetail()
            
            vc.configure(
                image: doctor.image,
                name: doctor.name,
                speciality: doctor.specialty,
                raiting: doctor.rating,
                reviews: doctor.reviewsCount,
                patientsCount: doctor.patientsCount,
                experience: doctor.experience,
                description: doctor.description
            )
            
            NavigationHelper.push(vc, from: self)
        }
    }
    
    private func setupActions() {
        seeAllBtn.addTarget(self, action: #selector(allDoctors), for: .touchUpInside)
    }
    
    private func SetupConstraints() {
        [profileMain, doctors, topDoctors, mainStack, titleTopDoctors, filters].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            profileMain.topAnchor.constraint(equalTo: view.topAnchor),
            profileMain.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileMain.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileMain.heightAnchor.constraint(equalToConstant: 220),
            
            filters.topAnchor.constraint(equalTo: profileMain.bottomAnchor, constant: 24),
            filters.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            filters.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            mainStack.topAnchor.constraint(equalTo: filters.bottomAnchor, constant: 24),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            mainStack.heightAnchor.constraint(equalToConstant: 24),
            
            doctors.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 16),
            doctors.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            doctors.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            doctors.heightAnchor.constraint(equalToConstant: 205),
            
            titleTopDoctors.topAnchor.constraint(equalTo: doctors.bottomAnchor, constant: 24),
            titleTopDoctors.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            titleTopDoctors.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            titleTopDoctors.heightAnchor.constraint(equalToConstant: 24),
            
            topDoctors.topAnchor.constraint(equalTo: titleTopDoctors.bottomAnchor, constant: 16),
            topDoctors.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            topDoctors.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            topDoctors.heightAnchor.constraint(equalToConstant: 228),
        ])
    }
}


extension FavoriteDoctors: ProfileMainViewOutput {
    func searchText(_ text: String) {
        doctors.filterDoctorsByName(text)
    }
}
