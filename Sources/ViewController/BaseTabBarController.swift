//
//  BaseTabBarController.swift
//  
//
//  Created by Kristof Kalai on 2022. 12. 08..
//

import Combine
import UIKit

public class BaseTabBarController<Tabs: ScreenTabs>: TabBarController<Tabs> {
    private let tabBarView: TabBar
    private var cancellables = Set<AnyCancellable>()

    public init(tabBarView: TabBar) {
        self.tabBarView = tabBarView
        super.init()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        tabBarView.selectedIndexSubject
            .dropFirst()
            .compactMap { [unowned self] in viewControllers?[$0] }
            .sink { [unowned self] destinationViewController in
                if let result = delegate?.tabBarController?(self, shouldSelect: destinationViewController) {
                    if result {
                        selectedViewController = destinationViewController
                    }
                } else {
                    selectedViewController = destinationViewController
                }
                if let selectedViewController {
                    delegate?.tabBarController?(self, didSelect: selectedViewController)
                }
            }
            .store(in: &cancellables)
    }

    public override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        tabBarView.setupItems(from: viewControllers)
        tabBarView.setSelectedIndex(index: .zero)
        selectedViewController = viewControllers?[.zero]

        let bottomSafeArea = tabBarView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        additionalSafeAreaInsets = .init(top: .zero,
                                         left: .zero,
                                         bottom: bottomSafeArea - UIApplication.shared.bottomSafeAreaInset,
                                         right: .zero)
    }
}

extension BaseTabBarController {
    public func setSelectedIndex(index: Int) {
        guard viewControllers?.indices.contains(index) == true else { return }
        selectedViewController = viewControllers?[index]
        tabBarView.setSelectedIndex(index: index)
    }
}

extension BaseTabBarController {
    private func setupTabBar() {
        tabBar.isHidden = true
        view.addSubview(tabBarView)
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
