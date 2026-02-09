import UIKit

final class CustomTabBar: UIView {

    var onSelect: ((Int) -> Void)?

    private let indicator = UIView()
    private var buttons: [UIButton] = []
    private var indicatorLeading: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupUI() {
        backgroundColor = .white

        let homeBtn = makeButton(image: "house.fill", tag: 0)
        let profileBtn = makeButton(image: "person", tag: 1)

        buttons = [homeBtn, profileBtn]

        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)
        addSubview(indicator)

        indicator.backgroundColor = .black
        indicator.layer.cornerRadius = 2
        indicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leftAnchor.constraint(equalTo: leftAnchor),
            stack.rightAnchor.constraint(equalTo: rightAnchor),
            stack.heightAnchor.constraint(equalToConstant: 56),

            indicator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            indicator.widthAnchor.constraint(equalToConstant: 24),
            indicator.heightAnchor.constraint(equalToConstant: 4)
        ])

        indicatorLeading = indicator.leftAnchor.constraint(equalTo: leftAnchor, constant: frame.width / 4 - 12)
        indicatorLeading.isActive = true

        select(index: 0)
    }

    private func makeButton(image: String, tag: Int) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: image), for: .normal)
        btn.tintColor = .lightGray
        btn.tag = tag
        btn.addTarget(self, action: #selector(tap(_:)), for: .touchUpInside)
        return btn
    }

    @objc private func tap(_ sender: UIButton) {
        select(index: sender.tag)
        onSelect?(sender.tag)
    }

    func select(index: Int) {
        for (i, btn) in buttons.enumerated() {
            btn.tintColor = i == index ? .systemIndigo : .lightGray
        }

        let itemWidth = frame.width / CGFloat(buttons.count)
        indicatorLeading.constant = itemWidth * CGFloat(index) + itemWidth / 2 - 12

        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
    }
}
