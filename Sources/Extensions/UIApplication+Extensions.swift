//
//  UIApplication+Extensions.swift
//
//
//  Created by Kristof Kalai on 2022. 12. 08..
//

import UIKit

extension UIApplication {
    private var _keyWindow: UIWindow? {
        connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .first(where: \.isKeyWindow)
    }

    var bottomSafeAreaInset: CGFloat {
        _keyWindow?.safeAreaInsets.bottom ?? .zero
    }

    var hasBottomSafeArea: Bool {
        bottomSafeAreaInset > .zero
    }
}
