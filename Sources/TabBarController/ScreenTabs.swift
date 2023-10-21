//
//  ScreenTabs.swift
//
//
//  Created by Kristof Kalai on 2022. 12. 08..
//

import UIKit

public protocol ScreenTabs {
    init()
    var viewControllers: [UIViewController] { get }
}

extension ScreenTabs {
    func setup(on tabBarController: UITabBarController) {
        tabBarController.setViewControllers(viewControllers, animated: false)

        if let selectedViewController = tabBarController.selectedViewController {
            tabBarController.delegate?.tabBarController?(tabBarController, didSelect: selectedViewController)
        }
    }
}
