//
//  AdaptiveTabBarContent.swift
//
//
//  Created by Kristof Kalai on 2022. 12. 08..
//

import UIKit

final class AdaptiveTabBarContent: UIView {
    private let stackView = UIStackView()
    private let visualEffectView = UIVisualEffectView()
    private var hasNotch = UIApplication.shared.hasBottomSafeArea
    private let showVisualEffectView: Bool

    init(showVisualEffectView: Bool) {
        self.showVisualEffectView = showVisualEffectView
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AdaptiveTabBarContent {
    private func setupView() {
        setupVisualEffectView()
        setupStackView()

        translatesAutoresizingMaskIntoConstraints = false
        if hasNotch {
            heightAnchor.constraint(equalToConstant: 91).isActive = true
        }
    }

    private func setupVisualEffectView() {
        guard showVisualEffectView else { return }
        let constant: CGFloat = {
            if hasNotch {
                visualEffectView.layer.cornerRadius = 32
                return 16
            }
            return .zero
        }()
        addSubview(visualEffectView)
        visualEffectView.clipsToBounds = true
        visualEffectView.effect = UIBlurEffect(style: .systemThinMaterial)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        visualEffectView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        visualEffectView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: constant).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -constant).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -constant).isActive = true
    }

    private func setupStackView() {
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        if showVisualEffectView {
            visualEffectView.contentView.addSubview(stackView)
        } else {
            addSubview(stackView)
        }
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }
}

extension AdaptiveTabBarContent {
    func setupItems(from viewControllers: [UIViewController]?,
                    unselectedColor: UIColor,
                    selectedColor: UIColor,
                    didTap: @escaping (TabBarItem) -> Void) -> [TabBarItem] {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        var tabBarItems = [TabBarItem]()
        viewControllers?.forEach {
            let tabBarItem = TabBarItem(tabBarItem: $0.tabBarItem,
                                        unselectedColor: unselectedColor,
                                        selectedColor: selectedColor)
            tabBarItems.append(tabBarItem)
            stackView.addArrangedSubview(tabBarItem)
        }

        tabBarItems.forEach { tabBarItem in
            tabBarItem.tapped = {
                didTap(tabBarItem)
            }
        }

        return tabBarItems
    }
}
