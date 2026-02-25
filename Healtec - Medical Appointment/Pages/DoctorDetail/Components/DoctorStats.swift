import UIKit

class DoctorStatsView: UIView {
    
    let patients = StatItemViewUI()
    let exp = StatItemViewUI()
    let rating = StatItemViewUI()
    let reviews = StatItemViewUI()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(patients)
    }
    
    func configure(icon: String, value: String, title: String) {
            patients.configure(
                icon: icon,
                value: value,
                title: title
            )
        
            exp.configure(
                icon: icon,
                value: value,
                title: title
            )
            
            rating.configure(
                icon: icon,
                value: value,
                title: title
            )
            
            reviews.configure(
                icon: icon,
                value: value,
                title: title
            )
        }
    
    private func setupConstrains() {
        [patients].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            patients.topAnchor.constraint(equalTo: self.topAnchor),
            patients.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            patients.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            patients.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

