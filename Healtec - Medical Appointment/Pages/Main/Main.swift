import UIKit

class FavoriteDoctors: UIViewController {
    private let doctors = DoctorsListCV()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        SetupConstraints()
    }
    
    private func SetupView() {
        view.backgroundColor = .white
        
        view.addSubview(doctors)
    }
    
    private func SetupConstraints() {
        [doctors].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            doctors.topAnchor.constraint(equalTo: view.topAnchor),
            doctors.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            doctors.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            doctors.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
