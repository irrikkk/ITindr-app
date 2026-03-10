import UIKit

final class GradientBackgroundView: UIView {

    private let purpleGradient = CAGradientLayer()
    private let blueGradient = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradients()
    }

    required init?(coder: NSCoder) {
        fatalError("error(")
    }

    private func setupGradients() {
        backgroundColor = UIColor(red: 31/255, green: 33/255, blue: 37/255, alpha: 1.0)

        configureRadialGradient(
            purpleGradient,
            color: UIColor(red: 175/255, green: 1/255, blue: 255/255, alpha: 1.0),
            start: CGPoint(x: 0.0, y: 0.42),
            end: CGPoint(x: 0.9, y: 0.87)
        )

        configureRadialGradient(
            blueGradient,
            color: UIColor(red: 90/255, green: 1/255, blue: 255/255, alpha: 1.0),
            start: CGPoint(x: 1.0, y: 0.0),
            end: CGPoint(x: 0.0, y: 0.8)
        )
    }

    private func configureRadialGradient(_ layer: CAGradientLayer, color: UIColor, start: CGPoint, end: CGPoint) {
        layer.type = .radial

        layer.colors = [
                color.withAlphaComponent(0.8).cgColor,
                color.withAlphaComponent(0.0).cgColor
            ]

        layer.locations = [
            0.0,
            1.0
        ]

        layer.startPoint = start
        layer.endPoint = end

        self.layer.addSublayer(layer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        purpleGradient.frame = bounds
        blueGradient.frame = bounds
    }
}
