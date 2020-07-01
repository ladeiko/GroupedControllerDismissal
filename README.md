# GroupedControllerDismissal

UIViewController extension to enable dismissing of stack of modal controller as single element.

**NOTE: At current moment only fullscreen mode is supported**

## Installation

### Cocoapods

```ruby
pod 'GroupedControllerDismissal'
```

### Usage

#### All controllers

```swift
import GroupedControllerDismissal

UIViewController.dismissModalAsGrouped = true
```

#### One controller

```swift
import GroupedControllerDismissal

func viewDidLoad() {
	super.viewDidLoad()
	self.dismissModalAsGrouped
}
```

or 

```swift
import GroupedControllerDismissal

someController.dismissGrouped(true, completion: nil)
```

## Authors

* Siarhei Ladzeika <sergey.ladeiko@gmail.com>

## LICENSE

See [LICENSE](LICENSE)
