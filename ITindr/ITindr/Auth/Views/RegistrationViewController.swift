import UIKit

class RegistrationViewController: UIViewController {

    private let backgroundView = GradientBackgroundView()
    private let mainTitleLabel = UILabel()
    private let emailTextField = CustomTextField()
    private let passwordTextField = CustomTextField()
    private let confirmPasswordTextField = CustomTextField()
    private let registerButton = CustomButton(style: .primary)
    private let backButton = CustomButton(style: .secondary)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        hideKeyboardWhenTappedAround()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func setupUI() {
        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false

        mainTitleLabel.text = "registration.title".localized
        mainTitleLabel.textColor = .white
        mainTitleLabel.font = UIFont(name: "Inter24pt-Bold", size: 40)
        mainTitleLabel.numberOfLines = 0
        mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        emailTextField.titleLabel.text = "Email"
        emailTextField.setPlaceholder("Ваш email")
        emailTextField.validator = EmailValidator()
        emailTextField.translatesAutoresizingMaskIntoConstraints = false

        passwordTextField.titleLabel.text = "registration.password".localized
        passwordTextField.setPlaceholder("Придумайте пароль")
        passwordTextField.validator = RequiredFieldValidator()
        passwordTextField.setSecureTextEntry(true)
        passwordTextField.informationImageView.isHidden = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false

        confirmPasswordTextField.titleLabel.text = "registration.repeatPassword".localized
        confirmPasswordTextField.setPlaceholder("Повторите пароль")
        confirmPasswordTextField.setSecureTextEntry(true)
        confirmPasswordTextField.validator = PasswordMatchValidator(originalPassword: { [weak self] in
            return self?.passwordTextField.textField.text ?? ""

        })
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false

        registerButton.label.text = "registration.primaryButton".localized
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.isEnabled = false
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)

        backButton.label.text = "registration.secondaryButton".localized
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        [emailTextField, passwordTextField, confirmPasswordTextField].forEach { field in
            field.onTextChanged = { [weak self] _ in
                self?.validateForm()
            }
        }

        passwordTextField.onInfoTap = { [weak self] in
            let alert = UIAlertController(
                title: "registration.password.hint.title".localized,
                message: "registration.password.hint.message".localized,
                preferredStyle: .alert
            )

            let okAction = UIAlertAction(title: "registration.alert.button".localized, style: .default)
            alert.addAction(okAction)

            self?.present(alert, animated: true)

        }
    }

    private func setupConstraints() {
        view.addSubview(mainTitleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(registerButton)
        view.addSubview(backButton)

        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            mainTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            mainTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),

            emailTextField.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 32),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 24),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),
            confirmPasswordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: -8),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -6),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)

        ])
    }

    private func validateForm() {
        let allFieldsValid =
        emailTextField.isValid &&
        passwordTextField.isValid &&
        confirmPasswordTextField.isValid

        registerButton.isEnabled = allFieldsValid
    }

    @objc private func registerButtonTapped() {
        let controller = AboutMyselfViewController()
        navigationController?.pushViewController(controller, animated: true)
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

}
