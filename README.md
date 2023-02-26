# TabBarController
UITabBarController got custom tab bar implementation! 😎

### How to use

First you should create the tabs:

```swift
final class MainScreenTabs: ScreenTabs {
    var viewControllers: [UIViewController] {
        [
            // put your UIViewControllers here
        ]
    }
}
```

You can create a `BaseTabBarController`:

```swift
let tabBarController = BaseTabBarController<MainScreenTabs>(tabBarView: AdaptiveTabBar(selectedColor: .red, unselectedColor: .blue))
addChild(tabBarController)
tabBarController.view.frame = view.bounds
view.addSubview(tabBarController.view)
tabBarController.didMove(toParent: self)
```

And then select the tab at any time programmatically:

```swift
tabBarController.setSelectedIndex(index: 2)
```

For details see the Example app.

### Example

<p style="text-align:center;"><img src="https://github.com/stateman92/TabBarController/blob/main/Resources/screenrecording.gif?raw=true" width="50%" alt="Example"></p>
