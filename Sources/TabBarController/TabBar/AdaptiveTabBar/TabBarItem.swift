//
//  TabBarItem.swift
//  
//
//  Created by Kristof Kalai on 2022. 12. 08..
//

import ColorChangingLabel
import UIKit

final class TabBarItem: UIView {
    var isSelected = false {
        didSet {
            setSelected(isSelected, duration: 0.66)
        }
    }
    var tapped: (() -> Void)?
    private let imageView = UIImageView()
    private let label = ColorChangingLabel()
    private lazy var stackView = UIStackView(arrangedSubviews: [imageView, UIView(), label, UIView()])
    private let tabBarItem: UITabBarItem
    private let unselectedColor: UIColor
    private let selectedColor: UIColor

    init(tabBarItem: UITabBarItem, unselectedColor: UIColor, selectedColor: UIColor) {
        self.tabBarItem = tabBarItem
        self.unselectedColor = unselectedColor
        self.selectedColor = selectedColor
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TabBarItem {
    private func setupView() {
        setupImageView()
        setupLabel()
        setupStackView()

        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewDidTap)))
    }

    private func setupImageView() {
        imageView.image = tabBarItem.image
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 33).isActive = true
    }

    private func setupLabel() {
        label.configureLabel {
            $0.numberOfLines = 1
            $0.text = tabBarItem.title
            $0.textAlignment = .center
        }
        label.setContentHuggingPriority(.required, for: .vertical)
    }

    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 4
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }

    private func setSelected(_ selected: Bool, duration: TimeInterval) {
        UIView.transition(with: imageView,
                          duration: duration,
                          options: .transitionCrossDissolve) { [self] in
            imageView.image = selected ? tabBarItem.selectedImage : tabBarItem.image
        }
        UIView.animate(withDuration: duration,
                       delay: .zero,
                       options: [.beginFromCurrentState, .allowUserInteraction]) { [self] in
            imageView.tintColor = selected ? selectedColor : unselectedColor
        }
        label.change(toColor: selected ? selectedColor : unselectedColor, duration: duration)
    }
}

extension TabBarItem {
    @objc private func viewDidTap() {
        tapped?()
    }
}
