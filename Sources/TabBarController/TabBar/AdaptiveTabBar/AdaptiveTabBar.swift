//
//  AdaptiveTabBar.swift
//
//
//  Created by Kristof Kalai on 2022. 12. 08..
//

import UIKit

public final class AdaptiveTabBar: BaseTabBar {
    private let contentView: AdaptiveTabBarContent
    private var tabBarItems: [TabBarItem] = []
    private let selectedColor: UIColor
    private let unselectedColor: UIColor

    public init(selectedColor: UIColor, unselectedColor: UIColor, showVisualEffectView: Bool = true) {
        self.selectedColor = selectedColor
        self.unselectedColor = unselectedColor
        contentView = AdaptiveTabBarContent(showVisualEffectView: showVisualEffectView)
        super.init()
        setupView()
    }

    public override func setupItems(from viewControllers: [UIViewController]?) {
        super.setupItems(from: viewControllers)
        tabBarItems = contentView.setupItems(from: viewControllers,
                                             unselectedColor: unselectedColor,
                                             selectedColor: selectedColor) { [weak self] tabBarItem in
            guard let self else { return }
            let index = self.tabBarItems.firstIndex(of: tabBarItem) ?? .zero
            self.sendActions(for: .valueChanged)
            self.selectedIndexSubject.send(index)
        }
    }

    public override func setSelectedIndex(index: Int) {
        super.setSelectedIndex(index: index)
        guard tabBarItems.indices.contains(index) else { return }
        let selectedItem = tabBarItems[index]
        let deselectItems = tabBarItems.filter { $0 != selectedItem }
        deselectItems.forEach { $0.isSelected = false }
        selectedItem.isSelected = true
    }
}

extension AdaptiveTabBar {
    private func setupView() {
        setupContentView()
    }

    private func setupContentView() {
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
