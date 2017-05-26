# MGRelativeKit

![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg)
[![Platform](https://img.shields.io/cocoapods/p/MGRelativeKit.svg?style=flat)](http://cocoapods.org/pods/MGRelativeKit)
[![Version](https://img.shields.io/cocoapods/v/MGRelativeKit.svg?style=flat)](http://cocoapods.org/pods/MGRelativeKit)
[![License](https://img.shields.io/cocoapods/l/MGRelativeKit.svg?style=flat)](http://cocoapods.org/pods/MGRelativeKit)

MGStarRatingView는 평가를 위한 뷰입니다. 간단하고 쉽게 구현 할수 있습니다. :sunny:

프로그래밍 방식과 xib 방식을 지원 합니다.<br>
이미지가 필요하지 않습니다. 그냥 컬러만 결정하면 됩니다.

## Sample
 <img src="https://github.com/magi82/MGStarRatingView/blob/master/Resources/sample.gif?raw=true" width="180">


## Usage (Programmatically)
- 뷰 생성 및 구현

```swift
let starView = StarRatingView()
let attribute = StarRatingAttribute(type: .rate,
      point: 30,
      spacing: 10,
      emptyColor: .red,
      fillColor: .blue)
starView.configure(attribute, current: 0, max: 5)
starView.delegate = self
self.view.addSubview(starView)
```

- 델리게이트 구현

```swift
func StarRatingValueChanged(value: CGFloat) {
  // use value
}
```

## Usage (xib)

`UIView`를 추가후 Custom Class를 `StarRatingView`로 등록 해주세요.

`Type String`의 스펠링을 틀리게 하면 적용 되지 않습니다. 주의해주세요.<br>
기본 타입은 `rate` 입니다.

<img src="https://github.com/magi82/MGStarRatingView/blob/master/Resources/xib_01.png?raw=true" width="200">   <img src="https://github.com/magi82/MGStarRatingView/blob/master/Resources/xib_02.png?raw=true" width="200">   <img src="https://github.com/magi82/MGStarRatingView/blob/master/Resources/xib_03.png?raw=true" width="200">

## API Reference

```swift
// 값을 받아오기 위한 델리게이트 입니다.
public var delegate: StarRatingDelegate?

// 값을 표현하는 타입입니다. 세가지 종류가 있습니다. (rate, half, fill)
public var type: StarRatingType

// 현재 값 입니다.
public var current: CGFloat

// 별의 최대 갯수 입니다.
public var max: Int

// 별 사이의 간격 입니다.
public var spacing: CGFloat

// 별의 크기 입니다. (가로와 세로의 크기는 같습니다.)
public var point: CGFloat

// 비어있는 별의 컬러 값입니다.
public var emptyColor: UIColor

// 가득 찬 별의 컬러 값입니다.
public var fillColor: UIColor
```

## Requirements

- Swift 3.0+
- Xcode 8.0+
- iOS 8.0+

## Installation

- **For iOS 8+ projects** with [CocoaPods](https://cocoapods.org):

```ruby
pod 'MGStarRatingView'
```

- **For iOS 8+ projects** with [Carthage](https://github.com/Carthage/Carthage):

```ruby
github "magi82/MGStarRatingView"
```

## Author

magi82, bkhwang82@gmail.com

## License

**MGStarRatingView** is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
