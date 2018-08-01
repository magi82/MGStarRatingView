# MGStarRatingView

![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg)
[![Platform](https://img.shields.io/cocoapods/p/MGStarRatingView.svg?style=flat)](http://cocoapods.org/pods/MGStarRatingView)
[![Version](https://img.shields.io/cocoapods/v/MGStarRatingView.svg?style=flat)](http://cocoapods.org/pods/MGStarRatingView)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CI Status](https://travis-ci.org/magi82/MGStarRatingView.svg?branch=master)](https://travis-ci.org/magi82/MGStarRatingView)
[![License](https://img.shields.io/cocoapods/l/MGStarRatingView.svg?style=flat)](http://cocoapods.org/pods/MGStarRatingView)

MGStarRatingView is a view for rating.<br>
Simple and easy to implement. :sunny:

It supports programmatically and xib.<br>
No image is required. Just choose color.

## Sample

<img src="https://github.com/magi82/MGStarRatingView/blob/master/Resources/sample.gif?raw=true" width="240">


## Usage (Programmatically)
- Creating and Implementing a View

```swift
let starView = StarRatingView()
let attribute = StarRatingAttribute(type: .rate,
      point: 30,
      spacing: 10,
      emptyColor: .red,
      fillColor: .blue,
      emptyImage: nil,
      fillImage: nil)
starView.configure(attribute, current: 0, max: 5)
starView.delegate = self
self.view.addSubview(starView)
```

- Delegate implementation

```swift
func StarRatingValueChanged(view: StarRatingView, value: CGFloat) {
  // use value
}
```

## Usage (xib)

First, add `UIView`.<br>
Register Custom Class as `StarRatingView` and register Module as `MGStarRatingView`.

*Please be careful.*<br>
If you type the spelling of `Type String` wrongly, it will be applied as the default type.<br>
The default type is `rate`.

<img src="https://github.com/magi82/MGStarRatingView/blob/master/Resources/xib_01.png?raw=true" width="200">   <img src="https://github.com/magi82/MGStarRatingView/blob/master/Resources/xib_02.png?raw=true" width="200">   <img src="https://github.com/magi82/MGStarRatingView/blob/master/Resources/xib_03.png?raw=true" width="200">

## API Reference

```swift
// A delegate for receiving values.
public weak var delegate: StarRatingDelegate?

// A type that represents a value.
// There are three kinds. (rate, half, fill)
public var type: StarRatingType

// The current value.
public var current: CGFloat

// The maximum number of stars.
public var max: Int

// The spacing between stars.
public var spacing: CGFloat

// The size of the star.
// The horizontal and vertical sizes are the same.
public var point: CGFloat

// The color value of the empty star.
public var emptyColor: UIColor

// The color value of the full star.
public var fillColor: UIColor

// The image object of the empty star.
var emptyImage: UIImage?

// The image object of the full star.
var fillImage: UIImage?
```

## Aid

- [taewan0530](https://github.com/taewan0530)

## Requirements

- Swift 3.0+
- Xcode 8.0+
- iOS 8.0+

## Installation

- **For iOS 8+ projects** with [CocoaPods](https://cocoapods.org):

```ruby
pod 'MGStarRatingView', '~> 0.3.0'
```

- **For iOS 8+ projects** with [Carthage](https://github.com/Carthage/Carthage):

```ruby
github "magi82/MGStarRatingView" ~> 0.3.0
```

## Author

magi82, bkhwang82@gmail.com

## License

**MGStarRatingView** is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
