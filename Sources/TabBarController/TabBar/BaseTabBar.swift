//
//  BaseTabBar.swift
//
//
//  Created by Kristof Kalai on 2022. 12. 08..
//

import Combine
import UIKit

public class BaseTabBar: UIControl, TabBar {
    public var selectedIndexSubject = CurrentValueSubject<Int, Never>(.zero)
    private var cancellables = Set<AnyCancellable>()

    public init() {
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setupItems(from viewControllers: [UIViewController]?) {}

    public func setSelectedIndex(index: Int) {}
}

extension BaseTabBar {
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        selectedIndexSubject
            .sink { [unowned self] in setSelectedIndex(index: $0) }
            .store(in: &cancellables)
    }
}
