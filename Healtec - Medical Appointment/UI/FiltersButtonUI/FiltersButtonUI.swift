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
        setTitleColor(.textGrey, for: .normal)
        setTitleColor(.white, for: .selected)
        titleLabel?.font = UIFont(name: "Inter-Regulat", size: 14)
        
        backgroundColor = .blurClr
        layer.cornerRadius = 8
        contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func buttonTapped() {
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundColor = .blurClr
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                if self.isSelected {
                    self.backgroundColor = .borderClr
                } else {
                    self.backgroundColor = .blurClr
                }
            }
        }
        
        isSelected.toggle()
    }
    
    func deselect() {
        isSelected = false
        backgroundColor = .clear
    }
}
