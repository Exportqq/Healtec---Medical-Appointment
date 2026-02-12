import UIKit

class AuthVC: UIViewController {
    private let authBackground: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.image = UIImage(named: "back")
        return img
    }()
    
    private let authTitle: UILabel = {
        let label = UILabel()
        label.text = "Login here"
        label.font = UIFont(name: "Poppins-Bold", size: 30)
        label.textColor = .borderClr
        return label
    }()
    
    private let authTxt: UILabel = {
        let label = UILabel()
        label.text = "Welcome back you’ve been missed!"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Poppins-Medium", size: 14)
        label.textColor = .black
        return label
    }()
    
    private let authUsername = PaddedTextField()
    
    private let authPassord = PaddedTextField()
    
    private let authButton = CustomBtnView()
    
    private let nextAuthStageBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Create new account" , for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)
        button.setTitleColor(.customGrey, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    private var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupActions()
    }
    
    @objc private func getNextStage() {
        NavigationHelper.push(RegisterVC(), from: self)
    }
    
    @objc private func successLogin() {
        NavigationHelper.push(MainTabBarController(), from: self)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        
        [authBackground, authTitle, authUsername, authPassord, authTxt, authButton, nextAuthStageBtn].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    deinit {
      print("auth did init")
    }
    
    private func setupActions() {
        nextAuthStageBtn.addTarget(self, action: #selector(getNextStage), for: .primaryActionTriggered)
        
        authUsername.configure(placeholder: "Username")
        authPassord.configure(placeholder: "Password")
        
        authButton.configure(title: "Sign in") {
            print("click")
            
            Task {
                do {
                    let auth = try await AuthService.shared.login (
                        username: self.authUsername.text ?? "",
                        password: self.authPassord.text ?? "",
                    )
                    
                    self.successLogin()
                    KeychainService.shared.saveToken(auth.token)
                    print("Успешно", auth.token)
                    
                    
                } catch {
                    print("Ошибка авторизации")
                }
            }
        }
    }
    
    private func setupConstraints() {
        
        [authBackground, authTitle, authTxt, authUsername, authPassord, authButton, nextAuthStageBtn].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            authBackground.topAnchor.constraint(equalTo: view.topAnchor),
            authBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            authTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            authTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            authTxt.topAnchor.constraint(equalTo: authTitle.bottomAnchor, constant: 8),
            authTxt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authTxt.heightAnchor.constraint(equalToConstant: 60),
            authTxt.widthAnchor.constraint(equalToConstant: 225),
            
            authUsername.topAnchor.constraint(equalTo: authTxt.bottomAnchor, constant: 50),
            authUsername.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authUsername.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            authUsername.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            authUsername.heightAnchor.constraint(equalToConstant: 64),
            
            authPassord.topAnchor.constraint(equalTo: authUsername.bottomAnchor, constant: 25),
            authPassord.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authPassord.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            authPassord.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            authPassord.heightAnchor.constraint(equalToConstant: 64),
            
            authButton.topAnchor.constraint(equalTo: authPassord.bottomAnchor, constant: 50),
            authButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            authButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            nextAuthStageBtn.topAnchor.constraint(equalTo: authButton.bottomAnchor, constant: 40),
            nextAuthStageBtn.centerXAnchor.constraint(equalTo: authButton.centerXAnchor),
        ])
    }
}
