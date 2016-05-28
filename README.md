# TweenController [![Swift v2.1.1](https://img.shields.io/badge/Swift-v2.2.1-orange.svg)](swift.org) ![License MIT](https://img.shields.io/badge/license-MIT-lightgrey.svg)

On the surface, TweenController makes it easy to build interactive menus and tutorials. Under the hood, it's a simple but powerful toolkit to interpolate between values that are *Tweenable*.

## Example
![Pinyada](https://raw.githubusercontent.com/daltonclaybrook/tween-controller/master/example.gif)

## Usage

Tween anything that is *Tweenable*, such as **CGAffineTransform**:

``` swift
func tweenTransform() {
    let transformA = CGAffineTransformIdentity
    let transformB = CGAffineTransformMakeScale(2.0, 2.0)
    let transformC = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
    
    controller.tweenFrom(transformA, at: 0.0)
        .to(transformB, at: 0.5)
        .thenTo(transformC, at: 1.0)
        .withAction(tweenView.layer.twc_applyAffineTransform)
}
```
or **UIColor**:

``` swift
func tweenColor() {
    let colorA = UIColor.greenColor()
    let colorB = UIColor.blueColor()
    let colorC = UIColor.redColor()
    tweenView.backgroundColor = colorA
    
    controller.tweenFrom(colorA, at: 0.0)
        .to(colorB, at: 0.5)
        .thenTo(colorC, at: 1.0)
        .withAction(tweenView.twc_applyBackgroundColor)
}
```
or your own custom type:

``` swift
enum Step: Int {
    case One = 1, Two = 2, Three = 3, Four = 4
}

extension Step: Tweenable {
	static func valueBetween(val1: Step, _ val2: Step, percent: Double) -> Step {
        let val = Int(round(Double(val2.rawValue - val1.rawValue) * percent + Double(val1.rawValue)))
        return Step(rawValue: max(min(val, 4), 1)) ?? .One
    }
}

func tweenStep() {
    tweenController.tweenFrom(Step.One, at: 0.0)
        .to(.Four, at: 0.25)
        .thenHoldUntil(0.75)
        .thenTo(.Two, at: 1.0)
        .withAction { step in
            // use step
        }
}
```

then simply call:

``` swift
// can be called in response to user interaction
// such as a gesture recognizer or scroll view
// or something else, like a CADisplayLink

// progress range is arbitrary
// you might choose to use a percentage, like 0.0 - 1.0
// or the content size of a scroll view

controller.updateProgress(newProgress)
```

You can also *observe boundaries*:

``` swift
func observeBoundaries() {
    tweenController.observeForwardBoundary(0.5) { 
        // halfway finished!
    }
    tweenController.observeBothBoundaries(0.75) { 
        // this is called when moving backwards or forwards
    }
}
```

## Standard Tweenables


* Double
* Float
* Int
* CGFloat
* CGPoint
* CGSize
* CGRect
* UIColor
* CGAffineTransform
* CATransform3D