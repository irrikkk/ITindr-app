import UIKit

class LoginViewController: UIViewController {

    private let backgroundView = GradientBackgroundView()
    private let mainTitleLabel = UILabel()
    private let emailTextField = CustomTextField()
    private let passwordTextField = CustomTextField()
    private let loginButton = CustomButton(style: .primary)
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

        mainTitleLabel.text = "login.title".localized
        mainTitleLabel.textColor = .white
        mainTitleLabel.font = UIFont(name: "Inter24pt-Bold", size: 40)
        mainTitleLabel.numberOfLines = 0
        mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        emailTextField.titleLabel.text = "Email"
        emailTextField.setPlaceholder("Ваш email")
        emailTextField.validator = EmailValidator()
        emailTextField.translatesAutoresizingMaskIntoConstraints = false

        passwordTextField.titleLabel.text = "login.password".localized
        passwordTextField.setPlaceholder("Ваш пароль")
        passwordTextField.validator = RequiredFieldValidator()
        passwordTextField.setSecureTextEntry(true)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false

        loginButton.label.text = "login.primaryButton".localized
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.isEnabled = false
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

        backButton.label.text = "login.secondaryButton".localized
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        [emailTextField, passwordTextField].forEach { field in
            field.onTextChanged = { [weak self] _ in
                self?.validateForm()
            }
        }
    }

    private func setupConstraints() {
        view.addSubview(mainTitleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
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

            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: -8),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -6),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)

        ])
    }

    private func validateForm() {
        let allFieldsValid = emailTextField.isValid && passwordTextField.isValid
        loginButton.isEnabled = allFieldsValid
    }

    @objc private func loginButtonTapped() {
        let controller = TabBarView()
        navigationController?.pushViewController(controller, animated: true)

    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
