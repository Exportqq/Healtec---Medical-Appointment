import UIKit

final class Filters: UIView {

    var onFilterSelected: ((String) -> Void)?

    private let filtersButton: [FiltersButtonUI] = [
        FiltersButtonUI(title: "🔥 All"),
        FiltersButtonUI(title: "🧠 Migraine"),
        FiltersButtonUI(title: "🦷 Caries"),
        FiltersButtonUI(title: "👀 Glaucoma"),
        FiltersButtonUI(title: "🌞 Acne"),
        FiltersButtonUI(title: "💉 Arrhythmia")
    ]

    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: filtersButton)
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupButtonActions()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
        setupButtonActions()
    }

    private func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
    }

    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }

    private func setupButtonActions() {
        for button in filtersButton {
            button.onTap = { [weak self] tappedButton in
                guard let self = self else { return }

                UIView.animate(withDuration: 0.2) {
                    self.filtersButton.forEach { $0.deselect() }
                }

                UIView.animate(withDuration: 0.2) {
                    tappedButton.select()
                }

                let title = tappedButton.title(for: .normal) ?? ""
                self.onFilterSelected?(title)
            }
        }

        filtersButton.first?.select()
    }
}
