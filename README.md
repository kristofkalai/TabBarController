# TabBarController
UITabBarController got custom tab bar implementation! 😎

## Setup

Add the following to `Package.swift`:

```swift
.package(url: "https://github.com/stateman92/TabBarController", exact: .init(0, 0, 2))
```

[Or add the package in Xcode.](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app)

## Usage

```swift
let tabBarController = BaseTabBarController<MainScreenTabs>(tabBarView: AdaptiveTabBar(selectedColor: .red, unselectedColor: .blue))
addChild(tabBarController)
tabBarController.view.frame = view.bounds
view.addSubview(tabBarController.view)
tabBarController.didMove(toParent: self)
// ...
tabBarController.setSelectedIndex(index: 2)
```

For details see the Example app.

## Example

<p style="text-align:center;"><img src="https://github.com/stateman92/TabBarController/blob/main/Resources/screenrecording.gif?raw=true" width="50%" alt="Example"></p>
