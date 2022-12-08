//
//  ViewController.swift
//  Example
//
//  Created by Kristof Kalai on 2022. 12. 08..
//

import TabBarController
import UIKit

final class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            let tabBarController = BaseTabBarController<MainScreenTabs>(tabBarView: AdaptiveTabBar(selectedColor: .red, unselectedColor: .blue))
            addChild(tabBarController)
            tabBarController.view.frame = view.bounds
            view.addSubview(tabBarController.view)
            tabBarController.didMove(toParent: self)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                tabBarController.setSelectedIndex(index: 2)
            }
        }

    }
}

final class MainScreenTabs {
    private var test1ViewController: UIViewController = {
        let viewController = UIViewController()
        viewController.title = "Test1"
        viewController.tabBarItem.image = .init(systemName: "person.3")
        viewController.tabBarItem.selectedImage = .init(systemName: "person.3.fill")
        viewController.view.backgroundColor = .green
        let subView = UIView()
        viewController.view.addSubview(subView)
        subView.backgroundColor = .white
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor).isActive = true
        subView.leadingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        subView.trailingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        subView.bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        return viewController
    }()
    private var test2ViewController: UIViewController = {
        let viewController = UIViewController()
        viewController.title = "Test2"
        viewController.tabBarItem.image = .init(systemName: "rectangle.3.group.bubble.left")
        viewController.tabBarItem.selectedImage = .init(systemName: "rectangle.3.group.bubble.left.fill")
        viewController.view.backgroundColor = .black
        return viewController
    }()
    private var test3ViewController: UIViewController = {
        let viewController = UIViewController()
        viewController.title = "Test3"
        viewController.tabBarItem.image = .init(systemName: "figure.walk.circle")
        viewController.tabBarItem.selectedImage = .init(systemName: "figure.walk.circle.fill")
        viewController.view.backgroundColor = .white
        return viewController
    }()
    private var test4ViewController: UIViewController = {
        let viewController = UIViewController()
        viewController.title = "Test4"
        viewController.tabBarItem.image = .init(systemName: "gearshape")
        viewController.tabBarItem.selectedImage = .init(systemName: "gearshape.fill")
        viewController.view.backgroundColor = .systemPink
        return viewController
    }()

    init() {}
}

extension MainScreenTabs: ScreenTabs {
    var viewControllers: [UIViewController] {
        [
            test1ViewController,
            test2ViewController,
            test3ViewController,
            test4ViewController
        ]
    }
}
