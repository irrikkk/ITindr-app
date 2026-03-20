import UIKit

class StartViewController: UIViewController {

    private let backgroundImageView = UIImageView()
    private let logoImageView = UIImageView()
    private let logoLabel = UILabel()
    private let registrationButton = CustomButton(style: .primary)
    private let loginButton = CustomButton(style: .secondary)
    private let parallaxMotion: CGFloat = 30
    private let mediumFeedback = UIImpactFeedbackGenerator(style: .light)

    private let heightLogo = 48
    private let widthLogo = 166
    private let widthScreen = 394

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private var didAnimate = false

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !didAnimate {
            startAnimation()
            didAnimate = true
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func setupUI() {
        backgroundImageView.image = UIImage(named: "start_screen")
        backgroundImageView.accessibilityIdentifier = "backgroundImageView"
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        addParallaxEffect(to: backgroundImageView, motion: parallaxMotion)

        logoImageView.image = UIImage(named: "logo_app")
        logoImageView.accessibilityIdentifier = "logoImageView"
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        logoLabel.text = "start.title".localized
        logoLabel.accessibilityIdentifier = "logoLabel"
        logoLabel.font = UIFont(name: "Inter24pt-Bold", size: 16)
        logoLabel.textColor = .white
        logoLabel.numberOfLines = 2
        logoLabel.textAlignment = .center
        logoLabel.translatesAutoresizingMaskIntoConstraints = false

        registrationButton.label.text = "start.registration".localized
        registrationButton.accessibilityIdentifier = "registrationButton"
        registrationButton.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
        registrationButton.translatesAutoresizingMaskIntoConstraints = false

        loginButton.label.text = "start.login".localized
        loginButton.accessibilityIdentifier = "loginButton"
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
}

    private func setConstraints() {
        view.addSubview(backgroundImageView)
        view.addSubview(logoImageView)
        view.addSubview(logoLabel)
        view.addSubview(registrationButton)
        view.addSubview(loginButton)

        let horizontalPadding: CGFloat = UIScreen.main.bounds.width <= 390 ? 20 : 99

        NSLayoutConstraint.activate([
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 2 * parallaxMotion),
            backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 2 * parallaxMotion),

            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Double(widthLogo)/Double(widthScreen)),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: Double(heightLogo)/Double(widthLogo)),

            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 12),
            logoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding),
            logoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding),

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

    @objc private func registrationButtonTapped() {
       let controller = RegistrationViewController()
       navigationController?.pushViewController(controller, animated: true)
    }

    @objc private func loginButtonTapped() {
       let controller = LoginViewController()
       navigationController?.pushViewController(controller, animated: true)
    }

    private func startAnimation() {
        logoImageView.transform = CGAffineTransform(translationX: 0, y: -60)
        logoImageView.alpha = 0

        logoLabel.transform = CGAffineTransform(translationX: 0, y: -60)
        logoLabel.alpha = 0

        registrationButton.transform = CGAffineTransform(translationX: 0, y: 60)
        registrationButton.alpha = 0

        loginButton.transform = CGAffineTransform(translationX: 0, y: 60)
        loginButton.alpha = 0

        backgroundImageView.alpha = 0

        mediumFeedback.prepare()

        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       options: [.curveEaseOut],
                       animations: {
            self.logoImageView.transform = .identity
            self.logoImageView.alpha = 1
            self.logoLabel.transform = .identity
            self.logoLabel.alpha = 1
            self.registrationButton.transform = .identity
            self.registrationButton.alpha = 1
            self.loginButton.transform = .identity
            self.loginButton.alpha = 1
            self.backgroundImageView.alpha = 1

        }, completion: { _ in
            self.mediumFeedback.impactOccurred(intensity: 0.7)
        })
    }

    private func addParallaxEffect(to view: UIView, motion: CGFloat = 30) {
        let horizontalMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontalMotion.minimumRelativeValue = -motion
        horizontalMotion.maximumRelativeValue = motion

        let verticalMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        verticalMotion.minimumRelativeValue = -motion
        verticalMotion.maximumRelativeValue = motion

        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [horizontalMotion, verticalMotion]

        view.addMotionEffect(motionEffectGroup)
    }
}
