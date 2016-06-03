# TweenController [![Swift v2.1.1](https://img.shields.io/badge/Swift-v2.2.1-orange.svg)](https://swift.org) ![License MIT](https://img.shields.io/badge/license-MIT-lightgrey.svg) [![CocoaPods](https://img.shields.io/badge/pod-v0.2.0-blue.svg)](https://cocoapods.org) [![Carthage](https://img.shields.io/badge/Carthage-compatible-green.svg)](https://github.com/Carthage/Carthage)

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

You can use *easing functions*:

``` swift
controller.tweenFrom(transformA, at: 0.0)
	.to(transformB, at: 1.0, withEasing: Easing.easeInOutQuart)
	.withAction(tweenView.layer.twc_applyAffineTransform)
```

You can use *[Key-Value Coding](https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/CoreAnimation_guide/Key-ValueCodingExtensions/Key-ValueCodingExtensions.html)*:

``` swift
controller.tweenFrom(0.0, at: 0.0)
	.to(M_PI * 8.0, at: 1.0)
	.withObject(tweenView.layer, keyPath: "transform.rotation.z")
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

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

``` bash
$ gem install cocoapods
```


To integrate TweenController into your Xcode project using CocoaPods, specify it in your `Podfile`:

``` ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'TweenController', '~> 0.2'
```

Then, run the following command:

``` bash
$ pod install
```

You should open the `{Project}.xcworkspace` instead of the `{Project}.xcodeproj` after you installed anything from CocoaPods.

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager for Cocoa application. To install the carthage tool, you can use [Homebrew](http://brew.sh).

``` bash
$ brew update
$ brew install carthage
```

To integrate TweenController into your Xcode project using Carthage, specify it in your `Cartfile`:

``` ogdl
github "daltonclaybrook/tween-controller" ~> 0.2
```

Then, run the following command to build the TweenController framework:

``` bash
$ carthage update

```

At last, you need to set up your Xcode project manually to add the TweenController framework.

On your application targets’ “General” settings tab, in the “Linked Frameworks and Libraries” section, drag and drop each framework you want to use from the Carthage/Build folder on disk.

On your application targets’ “Build Phases” settings tab, click the “+” icon and choose “New Run Script Phase”. Create a Run Script with the following content:

``` 
/usr/local/bin/carthage copy-frameworks
```

and add the paths to the frameworks you want to use under “Input Files”:

``` 
$(SRCROOT)/Carthage/Build/iOS/TweenController.framework
```

For more information about how to use Carthage, please see its [project page](https://github.com/Carthage/Carthage).


## Contact

Follow and contact me on [Twitter](http://twitter.com/daltonclaybrook). If you find an issue, just [open a ticket](https://github.com/daltonclaybrook/tween-controller/issues/new) on it. Pull requests are warmly welcome as well.

## License

TweenController is released under the MIT license. See LICENSE for details.
