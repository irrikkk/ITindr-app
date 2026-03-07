import UIKit

class TabBarItem: UIView {
    var tabItem: TabItem
    var imageRightConstraint: NSLayoutConstraint?

    private var isSmallScreen: Bool {
        UIScreen.main.bounds.width <= 375
    }

    var isActive: Bool = false {
        didSet {
            updateAppearance()
        }
    }

    var isSelected: (TabBarItem) -> Void

    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = isActive ? .white : .clear
        view.layer.cornerRadius = 24
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToTab)))
        view.addSubview(tabImage)
        view.addSubview(tabText)
        return view
    }()

    lazy var tabImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = tabItem.tabImage
        imageView.tintColor = isActive ? .black : .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var tabText: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = tabItem.tabText
        view.textColor = .black
        let fontSize: CGFloat = isSmallScreen ? 11 : 14
        view.font = UIFont(name: "Inter24pt-SemiBold", size: fontSize)
        return view
    }()

    init(tabItem: TabItem, imageRightConstraint: NSLayoutConstraint? = nil, isActive: Bool,
         isSelected: @escaping (TabBarItem) -> Void) {
        self.tabItem = tabItem
        self.imageRightConstraint = imageRightConstraint
        self.isActive = isActive
        self.isSelected = isSelected
        super.init(frame: .zero)

        addSubview(contentView)
        setupConstraints()
        updateAppearance()

        self.isActive = isActive
    }

    private func updateAppearance() {
        imageRightConstraint?.isActive = !isActive
        contentView.backgroundColor = isActive ? .white : .clear
        tabImage.tintColor = isActive ? .black : .white

        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }

    private func setupConstraints() {
        imageRightConstraint = tabImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        imageRightConstraint?.isActive = !isActive

        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),

            tabImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            tabImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            tabImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            tabText.leadingAnchor.constraint(equalTo: tabImage.trailingAnchor, constant: 4),
            tabText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tabText.centerYAnchor.constraint(equalTo: tabImage.centerYAnchor)

        ])

    }

    @objc func tapToTab() {
        self.isSelected(self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
