import UIKit

final class CustomTextField: UIView {
    var validator: Validator?
    var onInfoTap: (() -> Void)?
    var onTextChanged: ((String?) -> Void)?

    var isValid: Bool {
        return validator?.validate(text: textField.text) == nil && !(textField.text?.isEmpty ?? true)
    }

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Inter24pt-Bold", size: 16)
        label.textColor = .white
        return label
    }()

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Inter24pt-Regular", size: 16)
        textField.textColor = .white
        textField.backgroundColor = .white.withAlphaComponent(0.1)
        textField.layer.cornerRadius = 8
        textField.translatesAutoresizingMaskIntoConstraints = false

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return textField

    }()

    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Inter24pt-Regular", size: 12)
        label.textColor = .systemRed
        label.isHidden = true
        label.numberOfLines = 0
        return label
    }()

    lazy var informationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "info.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.isHidden = true
        imageView.isUserInteractionEnabled = true
        imageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 16).isActive = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(infoTapped))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()

    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, informationImageView, UIView()])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        return stackView
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleStackView, textField, errorLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("error(")
    }

    func setPlaceholder(_ text: String, color: UIColor = .white.withAlphaComponent(0.5)) {
        textField.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [.foregroundColor: color])
    }

    func setSecureTextEntry(_ isSecure: Bool) {
        textField.isSecureTextEntry = isSecure

        if isSecure {
            textField.textContentType = .oneTimeCode
        }
    }

    private func setupView() {
        addSubview(mainStackView)

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            textField.heightAnchor.constraint(equalToConstant: 48)
        ])

    }

    @objc private func textDidChange() {
        let currentText = textField.text

        let errorText = validator?.validate(text: currentText)

        updateUI(with: errorText)

        onTextChanged?(currentText)
    }

    private func updateUI(with error: String?) {
        let hasError = error != nil

        UIView.animate(withDuration: 0.3) {
            self.errorLabel.text = error

            self.errorLabel.isHidden = !hasError

            self.textField.layer.borderColor = hasError ? UIColor.systemRed.cgColor : UIColor.clear.cgColor

            self.textField.layer.borderWidth = hasError ? 1 : 0

            self.layoutIfNeeded()
        }
    }

    @objc private func infoTapped() {
        onInfoTap?()
    }
}
