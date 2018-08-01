// The MIT License (MIT)
//
// Copyright (c) 2017 ByungKook Hwang (https://magi82.github.io)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

public enum StarRatingType {
  case rate
  case half
  case fill
  
  static func type(by type: String) -> StarRatingType {
    switch type {
    case "rate":
      return .rate
    case "half":
      return .half
    case "fill":
      return .fill
    default:
      return .rate
    }
  }
}

public protocol StarRatingDelegate: class {
  func StarRatingValueChanged(view: StarRatingView, value: CGFloat)
}

public struct StarRatingAttribute {
  var type: StarRatingType = .rate
  var point: CGFloat = 16
  var spacing: CGFloat = 4
  var emptyColor: UIColor = .lightGray
  var fillColor: UIColor = .darkGray
  var emptyImage: UIImage?
  var fillImage: UIImage?
  
  public init() {}
  
  public init(type: StarRatingType,
              point: CGFloat,
              spacing: CGFloat,
              emptyColor: UIColor,
              fillColor: UIColor,
              emptyImage: UIImage? = nil,
              fillImage: UIImage? = nil) {
    self.type = type
    self.point = point
    self.spacing = spacing
    self.emptyColor = emptyColor
    self.fillColor = fillColor
    self.emptyImage = emptyImage
    self.fillImage = fillImage
  }
}

@IBDesignable
public class StarRatingView: UIView {
  public weak var delegate: StarRatingDelegate?
  
  public var type: StarRatingType = .rate {
    didSet {
      updateLocation(CGPoint(x: self.currentWidth, y: 0))
      setNeedsDisplay()
    }
  }
  @IBInspectable
  internal var typeString: String = "rate" {
    didSet {
      self.type = StarRatingType.type(by: typeString)
    }
  }
  @IBInspectable
  public var current: CGFloat = 0 {
    didSet {
      self.currentWidth = rateToWidth(self.current)
      setNeedsDisplay()
    }
  }
  @IBInspectable
  public var min: CGFloat = 0 {
    didSet {
      self.minWidth = rateToWidth(self.min)
    }
  }
  @IBInspectable
  public var max: CGFloat = 0 {
    didSet {
      self.maxWidth = rateToWidth(self.max)
      setNeedsDisplay()
      invalidateIntrinsicContentSize()
    }
  }
  @IBInspectable
  public var spacing: CGFloat = 0 {
    didSet {
      if self.spacing < 0 {
        self.spacing = 0
      }
      
      self.currentWidth = rateToWidth(self.current)
      self.maxWidth = rateToWidth(CGFloat(self.max))
      self.emptyStar = makeStarImage(pt: self.point, spacing: self.spacing, color: self.emptyColor, image: self.emptyImage)
      self.fillStar = makeStarImage(pt: self.point, spacing: self.spacing, color: self.fillColor, image: self.fillImage)
      setNeedsDisplay()
      invalidateIntrinsicContentSize()
    }
  }
  @IBInspectable
  public var point: CGFloat = 0 {
    didSet {
      self.currentWidth = rateToWidth(self.current)
      self.maxWidth = rateToWidth(CGFloat(self.max))
      self.emptyStar = makeStarImage(pt: self.point, spacing: self.spacing, color: self.emptyColor, image: self.emptyImage)
      self.fillStar = makeStarImage(pt: self.point, spacing: self.spacing, color: self.fillColor, image: self.fillImage)
      setNeedsDisplay()
      invalidateIntrinsicContentSize()
    }
  }
  @IBInspectable
  public var emptyColor: UIColor = UIColor.lightGray {
    didSet {
      self.emptyStar = makeStarImage(pt: self.point, spacing: self.spacing, color: self.emptyColor, image: self.emptyImage)
      setNeedsDisplay()
    }
  }
  @IBInspectable
  public var fillColor: UIColor = UIColor.black {
    didSet {
      self.fillStar = makeStarImage(pt: self.point, spacing: self.spacing, color: self.fillColor, image: self.fillImage)
      setNeedsDisplay()
    }
  }
  @IBInspectable
  public var emptyImage: UIImage? = nil {
    didSet {
      self.emptyStar = makeStarImage(pt: self.point, spacing: self.spacing, color: self.emptyColor, image: self.emptyImage)
      setNeedsDisplay()
    }
  }
  @IBInspectable
  public var fillImage: UIImage? = nil {
    didSet {
      self.fillStar = makeStarImage(pt: self.point, spacing: self.spacing, color: self.fillColor, image: self.fillImage)
      setNeedsDisplay()
    }
  }
  
  private var currentWidth: CGFloat = 0
  private var minWidth: CGFloat = 0
  private var maxWidth: CGFloat = 0
  private var emptyStar: UIImage?
  private var fillStar: UIImage?
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  public func configure(_ attribute: StarRatingAttribute, current: CGFloat = 0, min: CGFloat = 0, max: CGFloat = 0) {
    self.type = attribute.type
    self.point = attribute.point
    self.spacing = attribute.spacing
    self.emptyColor = attribute.emptyColor
    self.fillColor = attribute.fillColor
    self.emptyImage = attribute.emptyImage
    self.fillImage = attribute.fillImage
    
    self.current = current < min ? min : current
    self.min = min
    self.max = max
    
    self.backgroundColor = .clear
    self.frame.size = self.intrinsicContentSize
  }
  
  private func rateToWidth(_ rate: CGFloat) -> CGFloat {
    var width = self.point * CGFloat(rate)
    width = width + CGFloat(ceil(rate) - 1) * self.spacing
    
    return width
  }
  
  private func makeStar(_ size: CGFloat, color: UIColor) -> UIImage? {
    let starSize: Double = Double(size)
    let xCenter: Double = starSize * 0.5
    let yCenter: Double = starSize * 0.5
    let r: Double = starSize * 0.5
    let flip: Double = -1.0
    
    UIGraphicsBeginImageContextWithOptions(CGSize(width: starSize, height: starSize), false, 0)
    
    guard let currentContext = UIGraphicsGetCurrentContext() else {
      UIGraphicsEndImageContext()
      return nil
    }
    currentContext.setFillColor(color.cgColor)
    currentContext.setStrokeColor(color.cgColor)
    
    currentContext.move(to: CGPoint(x: xCenter, y: r * flip + yCenter))
    let theta: Double = 2.0 * .pi * (2.0 / 5.0)
    for i in 1 ..< 5 {
      let x: Double = Double(r * sin(Double(i) * theta))
      let y: Double = Double(r * cos(Double(i) * theta))
      currentContext.addLine(to: CGPoint(x: x + xCenter, y: y * flip + yCenter))
    }
    
    currentContext.closePath()
    currentContext.fillPath()
    let star = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    
    return star
  }
  
  private func makeStar(_ size: CGFloat, image: UIImage) -> UIImage? {
    let starSize: Double = Double(size)
    
    UIGraphicsBeginImageContextWithOptions(CGSize(width: starSize, height: starSize), false, 0)
    image.draw(in: CGRect(x: 0, y: 0, width: starSize, height: starSize))
    let star = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return star
  }
  
  private func makeStarImage(pt size: CGFloat, spacing: CGFloat, color: UIColor, image: UIImage?) -> UIImage? {
    var starOrigin: UIImage? = nil
    if let value = image {
      starOrigin = self.makeStar(size, image: value)
    }
    else {
      starOrigin = self.makeStar(size, color: color)
    }
    
    guard let star = starOrigin else { return nil }
    
    var size = star.size
    size.width = size.width + self.spacing
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    star.draw(at: CGPoint(x: 0, y: 0))
    let starImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return starImage
  }
  
  public override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    guard let emptyStar = self.emptyStar else { return }
    emptyStar.drawAsPattern(in: CGRect(x: 0, y: 0, width: self.maxWidth, height: emptyStar.size.height))
    
    if self.current > 0 {
      guard let fillStar = self.fillStar else { return }
      fillStar.drawAsPattern(in: CGRect(x: 0, y: 0, width: self.currentWidth, height: fillStar.size.height))
    }
  }
  
  private func updateLocation(_ location: CGPoint) {
    switch self.type {
    case .rate:
      var width = location.x < 0 ? 0 : location.x
      width = width < self.minWidth ? self.minWidth : width
      width = width > self.maxWidth ? self.maxWidth : width
      self.currentWidth = width
      
      var count: CGFloat = 0
      while width > 0 {
        if width >= self.point {
          count = count + 1
          width = width - (self.point + self.spacing)
        }
        else {
          count = count + (width / self.point)
          width = width - (self.point + self.spacing)
        }
      }
      
      self.current = count
      delegate?.StarRatingValueChanged(view: self, value: count)
      break
      
    case .half:
      var width = location.x < 0 ? 0 : location.x
      width = width < self.minWidth ? self.minWidth : width
      width = width > self.maxWidth ? self.maxWidth : width
      
      var count: CGFloat = 0
      while width > 0 {
        if width >= self.point {
          count = count + 1
          width = width - (self.point + self.spacing)
        }
        else {
          count = count + (width / self.point)
          width = width - (self.point + self.spacing)
        }
      }
      
      self.current = floor(count)
      let remainder = count - self.current
      if remainder > 0.5 {
        self.current += 1
      }
      else if remainder > 0 {
        self.current += 0.5
      }
      
      self.currentWidth = rateToWidth(self.current)
      delegate?.StarRatingValueChanged(view: self, value: self.current)
      break
      
    case .fill:
      var width = location.x < 0 ? 0 : location.x
      width = width < self.minWidth ? self.minWidth : width
      width = width > self.maxWidth ? self.maxWidth : width
      
      var count: CGFloat = 0
      while width > 0 {
        if width >= self.point {
          count = count + 1
          width = width - (self.point + self.spacing)
        }
        else {
          count = count + (width / self.point)
          width = width - (self.point + self.spacing)
        }
      }
      
      self.current = ceil(count)
      self.currentWidth = rateToWidth(self.current)
      delegate?.StarRatingValueChanged(view: self, value: self.current)
      break
    }
  }
  
  public override var intrinsicContentSize: CGSize {
    let count = CGFloat(self.max)
    var width = self.point * count
    width = width + CGFloat(count - 1) * self.spacing
    return CGSize(width: width, height: self.point)
  }
  
  public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    
    if let location = touches.first?.location(in: self) {
      updateLocation(location)
      setNeedsDisplay()
    }
  }
  
  public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesMoved(touches, with: event)
    
    if let location = touches.first?.location(in: self) {
      updateLocation(location)
      setNeedsDisplay()
    }
  }
  
  public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    
    if let location = touches.first?.location(in: self) {
      updateLocation(location)
      setNeedsDisplay()
    }
  }
}
