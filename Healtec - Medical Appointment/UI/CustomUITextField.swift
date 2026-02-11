import UIKit

final class PaddedTextField: UITextField {

    var padding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

    private let activeBorderColor = UIColor.borderClr.cgColor
    private let inactiveBorderColor = UIColor.clear.cgColor

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        layer.borderWidth = 0
        layer.borderColor = inactiveBorderColor
        layer.cornerRadius = 10
        backgroundColor = .fillGrey
        textColor = .textGrey
        font = UIFont(name: "Poppins-Medium", size: 16)
    }

    func configure(placeholder: String) {
        self.placeholder = placeholder
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        animateBorder(toWidth: 2, toColor: activeBorderColor)
        return result
    }

    override func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        animateBorder(toWidth: 0, toColor: inactiveBorderColor)
        return result
    }

    private func animateBorder(toWidth width: CGFloat, toColor color: CGColor) {
        let widthAnimation = CABasicAnimation(keyPath: "borderWidth")
        widthAnimation.fromValue = layer.borderWidth
        widthAnimation.toValue = width

        let colorAnimation = CABasicAnimation(keyPath: "borderColor")
        colorAnimation.fromValue = layer.borderColor
        colorAnimation.toValue = color

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [widthAnimation, colorAnimation]
        animationGroup.duration = 0.2
        animationGroup.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        layer.add(animationGroup, forKey: "borderAnimation")

        layer.borderWidth = width
        layer.borderColor = color
    }
}
