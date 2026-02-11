import UIKit

class MainVC: UIViewController {
    private let testCard = DoctorCardUIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        setupConstraints()
        
        setupOptions()
    }
    
    private func SetupView() {
        view.backgroundColor = .white
        view.addSubview(testCard)
    }
    
    private func setupOptions() {
        testCard.doctorInfo.configure(name: "Dr. John", speciality: "Dentist", raiting: 5.0)
    }
    
    private func setupConstraints() {
        [testCard].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            testCard.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            testCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            testCard.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            testCard.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
    }
}
