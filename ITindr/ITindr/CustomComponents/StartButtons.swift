import UIKit

enum CustomButtonStyle {
    case primary
    case secondary
}

final class CustomButton: UIControl {
    private let style: CustomButtonStyle

    lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Inter24pt-Bold", size: 16)
        return label
    }()

    override var intrinsicContentSize: CGSize {
        CGSize(width: self.bounds.width, height: 56)
    }

    override var isHighlighted: Bool {
        didSet {
            updateHighlighted()
        }
    }

    init (style: CustomButtonStyle) {
        self.style = style
        super.init(frame: .zero)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("error(")
    }

    private func setup() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        layer.cornerRadius = 16
        clipsToBounds = true

        updateStyle()
    }

    private func updateStyle() {
        switch style {
        case .primary:
            backgroundColor = .white
            label.textColor = .black
        case .secondary:
            backgroundColor = UIColor.white.withAlphaComponent(0.2)
            label.textColor = .white
        }
    }

    private func updateHighlighted() {
        UIView.animate(withDuration: 0.15) {
            self.alpha = self.isHighlighted ? 0.7 : 1.0
            self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.97, y: 0.97) : .identity
        }
    }
}
