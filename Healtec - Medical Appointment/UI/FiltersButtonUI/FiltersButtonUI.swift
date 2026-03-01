import UIKit

class FiltersButtonUI: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
    }
    
    private func setupButton() {
        setTitleColor(.blurClr, for: .normal)
        setTitleColor(.borderClr, for: .highlighted)
        titleLabel?.font = UIFont(name: "Inter-Regulat", size: 14)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
