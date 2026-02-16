import UIKit

class DoctorsListViewController: UIViewController {
    
    private let doctorsView = DoctorsListCV()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        view.addSubview(doctorsView)
    }
    
    private func setupConstraints() {
        doctorsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            doctorsView.topAnchor.constraint(equalTo: view.topAnchor),
            doctorsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            doctorsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            doctorsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
