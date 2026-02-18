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
    
    private let doctors = DoctorsListFavouriteCV()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        SetupConstraints()
        setupActions()
    }
    
    private func SetupView() {
        view.backgroundColor = .white
        
        view.addSubview(mainStack)
        view.addSubview(doctors)
        view.addSubview(profileMain)
    }
    
    @objc private func allDoctors() {
        NavigationHelper.present(
            DoctorsListViewController(),
            from: self,
            style: .pageSheet
        )
    }
    
    private func setupActions() {
        seeAllBtn.addTarget(self, action: #selector(allDoctors), for: .touchUpInside)
    }
    
    private func SetupConstraints() {
        [profileMain, doctors, mainStack].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            profileMain.topAnchor.constraint(equalTo: view.topAnchor),
            profileMain.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileMain.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileMain.heightAnchor.constraint(equalToConstant: 220),
            
            mainStack.topAnchor.constraint(equalTo: profileMain.bottomAnchor, constant: 24),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            mainStack.heightAnchor.constraint(equalToConstant: 24),
            
            doctors.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 16),
            doctors.bottomAnchor.constraint(equalTo: view.bottomAnchor), //  constant: -90 скрыть таббар
            doctors.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            doctors.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ])
    }
}


