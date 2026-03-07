import UIKit

class TabBarView: UITabBarController {

    let tabItems: [TabItem] = [
        TabItem(index: 0, tabText: "tabBar.flow".localized, tabImage: UIImage(named: "icon_flow")),
        TabItem(index: 1, tabText: "tabBar.people".localized, tabImage: UIImage(named: "icon_people")),
        TabItem(index: 2, tabText: "tabBar.chats".localized, tabImage: UIImage(named: "icon_chat")),
        TabItem(index: 3, tabText: "tabBar.profile".localized, tabImage: UIImage(named: "icon_user"))
    ]

    lazy var tabView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "custom_gray")
        view.clipsToBounds = true
        view.layer.cornerRadius = 32
        view.addSubview(tabStackView)
        return view
    }()

    lazy var tabStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        tabBar.isHidden = true
        setViewControllers(setupViewControllers(), animated: true)
        setupConstraints()
        setupTabBar(pages: tabItems)

    }

    private func setupViewControllers() -> [UIViewController] {

        let flowVC = FlowViewController()
        let peopleVC = PeopleViewController()
        let chatsVC = ChatsViewController()
        let profileVC = ProfileViewController()

        return [flowVC, peopleVC, chatsVC, profileVC]
    }

    private func setupTabBar(pages: [TabItem]) {
        pages.enumerated().forEach { item in
            if item.offset == 0 {
                tabStackView.addArrangedSubview(createOneTabItem(item: item.element, isFisrt: true))

            } else {
                tabStackView.addArrangedSubview(createOneTabItem(item: item.element, isFisrt: false))

            }
        }
    }

    private func createOneTabItem(item: TabItem, isFisrt: Bool = false) -> UIView {
        TabBarItem(tabItem: item, isActive: isFisrt) { [weak self] selectedItem in
            guard let self = self else { return }

            for view in tabStackView.arrangedSubviews {
                guard let tabItem = view as? TabBarItem else { continue }
                tabItem.isActive = false
            }

            selectedItem.isActive.toggle()
            self.selectedIndex = item.index
        }
    }

    private func setupConstraints() {
        view.addSubview(tabView)

        NSLayoutConstraint.activate([
            tabView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -6),
            tabView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 54.5),
            tabView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -55.5),
            tabView.heightAnchor.constraint(equalToConstant: 64),

            tabStackView.topAnchor.constraint(equalTo: tabView.topAnchor),
            tabStackView.bottomAnchor.constraint(equalTo: tabView.bottomAnchor),
            tabStackView.leadingAnchor.constraint(equalTo: tabView.leadingAnchor, constant: 8),
            tabStackView.trailingAnchor.constraint(equalTo: tabView.trailingAnchor, constant: -8)
        ])
    }
}
