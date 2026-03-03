import UIKit

private let backgroundImageView = UIImageView()
private let logoImageView = UIImageView()
private let logoLabel = UILabel()
private let registrationButton = UIButton()
private let loginButton = UIButton()

class StartViewController: UIViewController {

    private let heightLogo = 48
    private let widthLogo = 166
    private let widthScreen = 394

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
    }

    private func setupUI() {
        backgroundImageView.image = UIImage(named: "start_screen")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false

        logoImageView.image = UIImage(named: "logo_app")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        logoLabel.text = """
        Ты найдёшь того, 
        кто поревьюит твой код
        """
        logoLabel.font = UIFont(name: "Inter24pt-Bold", size: 16)
        logoLabel.textColor = .white
        logoLabel.numberOfLines = 2
        logoLabel.textAlignment = .center
        logoLabel.translatesAutoresizingMaskIntoConstraints = false

        registrationButton.setTitle("Зарегистрироваться", for: .normal)
        registrationButton.setTitleColor(.black, for: .normal)
        registrationButton.titleLabel?.font = UIFont(name: "Inter24pt-Bold", size: 16)
        registrationButton.layer.cornerRadius = 16
        registrationButton.backgroundColor = .white
        registrationButton.translatesAutoresizingMaskIntoConstraints = false

        loginButton.setTitle("Войти", for: .normal)
        registrationButton.setTitleColor(.black, for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "Inter24pt-Bold", size: 16)
        loginButton.tintColor = .white
        loginButton.layer.cornerRadius = 16
        loginButton.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
}

    private func setConstraints() {
        view.addSubview(backgroundImageView)
        view.addSubview(logoImageView)
        view.addSubview(logoLabel)
        view.addSubview(registrationButton)
        view.addSubview(loginButton)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Double(widthLogo)/Double(widthScreen)),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: Double(heightLogo)/Double(widthLogo)),

            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 12),
            logoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 99),
            logoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -99),

            registrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registrationButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -8),
            registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            registrationButton.heightAnchor.constraint(equalToConstant: 56),

            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -6),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            loginButton.heightAnchor.constraint(equalToConstant: 56)

        ])
    }
}
