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
    
    private let regUsername = PaddedTextField()
    
    private let regPassord = PaddedTextField()
    
    private let regRepeatPassord = PaddedTextField()
    
    private let regButton = CustomBtnView()
    
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
        setupView()
        setupConstraints()
        setupActions()
    }
    
    deinit {
      print("registration did init")
    }
    
    @objc private func getNextStage() {
        NavigationHelper.pop(from: self)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        
        [regBackground, regTitle, regUsername, regPassord, regRepeatPassord, regTxt, regButton , nextAuthStageBtn].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
       
    }
    
    private func setupActions() {
        nextAuthStageBtn.addTarget(self, action: #selector(getNextStage), for: .primaryActionTriggered)
        
        regUsername.configure(placeholder: "Username")
        regPassord.configure(placeholder: "Password")
        regRepeatPassord.configure(placeholder: "Confirm Password")
        
        regButton.configure(title: "Sign up") { [weak self] in
            guard let self else { return }
            
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
    
    private func setupConstraints() {
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
