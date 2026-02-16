import UIKit

class FavoriteDoctors: UIViewController {
    
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
        button.setTitleColor(.textBlack, for: .normal)
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
    
    private let doctors = DoctorsListView()
    
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
        [doctors, mainStack].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            mainStack.heightAnchor.constraint(equalToConstant: 24),
            
            doctors.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            doctors.bottomAnchor.constraint(equalTo: view.bottomAnchor), //  constant: -90 скрыть таббар
            doctors.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            doctors.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ])
    }
}
