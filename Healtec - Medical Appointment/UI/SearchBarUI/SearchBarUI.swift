import UIKit

class SearchBarUI: UIView {

    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search"
        sb.searchBarStyle = .minimal
        sb.backgroundImage = UIImage()
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        customize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(searchBar)

        layer.cornerRadius = 14
        layer.borderWidth = 2
        layer.borderColor = UIColor(
            red: 237/255,
            green: 237/255,
            blue: 252/255,
            alpha: 0.20
        ).cgColor
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }

    private func customize() {
        guard let textField = searchBar.searchTextField as UITextField? else { return }

        textField.backgroundColor = .clear
        textField.borderStyle = .none
        textField.clearButtonMode = .never
        textField.textColor = .white

        let icon = UIImage(named: "search")
        textField.attributedPlaceholder = NSAttributedString(
            string: "Search Doctor. . .",
            attributes: [
                .foregroundColor: UIColor(
                    red: 237/255,
                    green: 237/255,
                    blue: 252/255,
                    alpha: 0.40
                )
            ]
        )
        let iconView = UIImageView(image: icon)
        iconView.contentMode = .scaleAspectFit
        iconView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)

        textField.leftView = iconView
        textField.leftViewMode = .always
    }
}
