import UIKit

class RegisterVC: UIViewController {
    private let regBackground: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.image = UIImage(named: "back")
        return img
    }()
    
    private let regTitle: UILabel = {
        let label = UILabel()
        label.text = "Create Account"
        label.font = UIFont(name: "Poppins-Bold", size: 30)
        label.textColor = .borderClr
        return label
    }()
    
    private let regTxt: UILabel = {
        let label = UILabel()
        label.text = "Create an account so you can explore all the existing jobs"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Poppins-Medium", size: 14)
        label.textColor = .black
        return label
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
    
    private let regRepeatPassord: UITextField = {
        let textField = PaddedTextField()
        textField.font = UIFont(name: "Poppins-Medium", size: 16)
        textField.placeholder = "Confirm Password"
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .fillGrey
        textField.textColor = .textGrey
        return textField
    }()
    
    let regButton = CustomBtnView()
    
    private let nextAuthStageBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Already have an account" , for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)
        button.setTitleColor(.customGrey, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        SetupConstraints()
        setupActions()
    }
    
    @objc private func getNextStage() {
        let vc = AuthVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func SetupView() {
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        
        view.addSubview(regBackground)
        view.addSubview(regTitle)
        view.addSubview(regUsername)
        view.addSubview(regPassord)
        view.addSubview(regRepeatPassord)
        view.addSubview(regTxt)
        view.addSubview(regButton)
        view.addSubview(nextAuthStageBtn)
    }
    
    private func setupActions() {
        nextAuthStageBtn.addTarget(self, action: #selector(getNextStage), for: .primaryActionTriggered)
        
        regButton.configure(title: "Sign up") {
            print("click")
            
            Task {
                do {
                    let auth = try await AuthService.shared.register(
                        username: self.regUsername.text ?? "",
                        password: self.regPassord.text ?? "",
                        repeatPassword: self.regRepeatPassord.text ?? ""
                    )
                    
                    print("Успешно", auth.token)
                } catch {
                    print("Ошибка регистрации")
                }
            }
        }
    }
    
    private func SetupConstraints() {
        [regBackground, regTitle, regTxt, regUsername, regPassord, regRepeatPassord, regButton, nextAuthStageBtn].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            regBackground.topAnchor.constraint(equalTo: view.topAnchor),
            regBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            regTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            regTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            regTxt.topAnchor.constraint(equalTo: regTitle.bottomAnchor, constant: 8),
            regTxt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            regTxt.heightAnchor.constraint(equalToConstant: 42),
            regTxt.widthAnchor.constraint(equalToConstant: 326),
            
            regUsername.topAnchor.constraint(equalTo: regTxt.bottomAnchor, constant: 50),
            regUsername.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            regUsername.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            regUsername.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            regUsername.heightAnchor.constraint(equalToConstant: 64),
            
            regPassord.topAnchor.constraint(equalTo: regUsername.bottomAnchor, constant: 25),
            regPassord.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            regPassord.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            regPassord.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            regPassord.heightAnchor.constraint(equalToConstant: 64),
            
            regRepeatPassord.topAnchor.constraint(equalTo: regPassord.bottomAnchor, constant: 25),
            regRepeatPassord.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            regRepeatPassord.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            regRepeatPassord.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            regRepeatPassord.heightAnchor.constraint(equalToConstant: 64),
            
            regButton.topAnchor.constraint(equalTo: regRepeatPassord.bottomAnchor, constant: 50),
            regButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            regButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            regButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            nextAuthStageBtn.topAnchor.constraint(equalTo: regButton.bottomAnchor, constant: 40),
            nextAuthStageBtn.centerXAnchor.constraint(equalTo: regButton.centerXAnchor),
        ])
    }
}
