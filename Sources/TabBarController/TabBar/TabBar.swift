//
//  TabBar.swift
//  
//
//  Created by Kristof Kalai on 2022. 12. 08..
//

import Combine
import UIKit

public protocol TabBar: UIView {
    var selectedIndexSubject: CurrentValueSubject<Int, Never> { get }
    func setupItems(from viewControllers: [UIViewController]?)
    func setSelectedIndex(index: Int)
}
