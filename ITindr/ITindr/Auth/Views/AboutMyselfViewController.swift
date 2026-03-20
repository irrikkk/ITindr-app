import UIKit

private let skipButton = UIButton()

class AboutMyselfViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(skipButton)
        setupUI()
        setupConstraints()

        title = "aboutMyself.title".localized
    }

    private func setupUI() {
        skipButton.setTitle("aboutMyself.skip".localized, for: .normal)
        skipButton.accessibilityIdentifier = "skipButton"
        skipButton.setTitleColor(.black, for: .normal)
        skipButton.titleLabel?.font = UIFont(name: "Inter24pt-Bold", size: 16)
        skipButton.tintColor = .white
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -6),
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            skipButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

    @objc private func skipButtonTapped() {
        let controller = TabBarView()
        navigationController?.pushViewController(controller, animated: true)

    }
}
