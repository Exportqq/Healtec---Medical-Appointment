import UIKit

protocol ProfileMainViewOutput: AnyObject {
    func searchText(_ text: String)
}

class ProfileMainView: UIView {
    
    weak var output: ProfileMainViewOutput?
    
    private let backgorund: UIView = {
        let view = UIView()
        view.backgroundColor = .borderClr
        view.clipsToBounds = true
        return view
    }()
    
    private let backgroundTexture: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profileTexture")
        return imageView
    }()
    
    private let profileItemsMain = ProfileItemsMainView()
    
    private lazy var searchBar = SearchBarUI(searchDelegate: self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        
        loadProfile()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(backgorund)
        backgorund.addSubview(backgroundTexture)
        backgorund.addSubview(profileItemsMain)
        backgorund.addSubview(searchBar)
    }
    
    
    
    private func loadProfile() {
        Task {
            do {                
                let profile = try await AuthService.shared.getProfile()
                await MainActor.run {
                    self.profileItemsMain.configure(username: profile.username)
                    
                }
            } catch {
                print("Ошибка загрузки профиля:", error)
            }
        }
    }
    
    private func setupConstraints() {
        [backgorund, backgroundTexture, profileItemsMain, searchBar].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            backgorund.topAnchor.constraint(equalTo: topAnchor),
            backgorund.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgorund.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgorund.heightAnchor.constraint(equalToConstant: 220),
            
            profileItemsMain.topAnchor.constraint(equalTo: backgorund.topAnchor),
            profileItemsMain.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            profileItemsMain.heightAnchor.constraint(equalToConstant: 51),
            
            searchBar.bottomAnchor.constraint(equalTo: backgorund.bottomAnchor, constant: -24),
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            searchBar.heightAnchor.constraint(equalToConstant: 53),

            backgroundTexture.topAnchor.constraint(equalTo: backgorund.topAnchor),
            backgroundTexture.centerXAnchor.constraint(equalTo: backgorund.centerXAnchor),
            
        ])
    }
}

// MARK: - UISearchBarDelegate

extension ProfileMainView: UISearchBarDelegate {
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {

  }

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      
      output?.searchText(searchText)
      
//    if searchText.isEmpty {
//
//    } else {
//
//    }
//
//    NSObject.cancelPreviousPerformRequests(withTarget: self,
//                                           selector: #selector(self.reloadSearch(_:)),
//                                           object: searchBar)
//    perform(#selector(self.reloadSearch(_:)), with: searchBar, afterDelay: 0.75)
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

    searchBar.resignFirstResponder()
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text = ""

    searchBar.resignFirstResponder()
  }

  @objc private func reloadSearch(_ searchBar: UISearchBar) {
    guard let text = searchBar.text else { return }
    if text.count > 2 || text.count == 0 {

    }
  }
}
