import UIKit

class Register: UIViewController {
    private let regBackground: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.image = UIImage(named: "back")
        return img
    }()
    
    private let regUsername: UITextField = {
        let textField = PaddedTextField()
        textField.font = UIFont(name: "Poppins-Medium", size: 16)
        textField.placeholder = "Username"
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .fillGrey
        textField.textColor = .textGrey
        return textField
    }()
    
    private let regPassord: UITextField = {
        let textField = PaddedTextField()
        textField.font = UIFont(name: "Poppins-Medium", size: 16)
        textField.placeholder = "Password"
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .fillGrey
        textField.textColor = .textGrey
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        SetupConstraints()
    }
    
    private func SetupView() {
        view.backgroundColor = .white
        
        view.addSubview(regBackground)
        view.addSubview(regUsername)
        view.addSubview(regPassord)
    }
    
    private func SetupConstraints() {
        [regBackground, regUsername, regPassord].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            regBackground.topAnchor.constraint(equalTo: view.topAnchor),
            regBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            regUsername.topAnchor.constraint(equalTo: regBackground.bottomAnchor, constant: 100),
            regUsername.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            regUsername.widthAnchor.constraint(equalToConstant: 357),
            regUsername.heightAnchor.constraint(equalToConstant: 64),
            
            regPassord.topAnchor.constraint(equalTo: regUsername.bottomAnchor, constant: 30),
            regPassord.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            regPassord.widthAnchor.constraint(equalToConstant: 357),
            regPassord.heightAnchor.constraint(equalToConstant: 64),
        ])
    }
}
