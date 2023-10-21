//
//  TabBarController.swift
//
//
//  Created by Kristof Kalai on 2022. 12. 08..
//

import UIKit

public class TabBarController<Tabs: ScreenTabs>: UITabBarController {
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        Tabs().setup(on: self)
    }
}
