//
//  Tweenable.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/9/16.
//
//  Copyright (c) 2017 Dalton Claybrook
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

/// Types that conform to `Tweenable` can be used by a `TweenController` in order to perform tween operations.
/// Most commonly, you'll use a type defined in Swift or iOS:
/// * Double
/// * Float
/// * Int
/// * CGFloat
/// * CGPoint
/// * CGSize
/// * CGRect
/// * UIColor
/// * CGAffineTransform
/// * CATransform3D
///
/// You can also make your own types conform to `Tweenable`.
public protocol Tweenable {
    
    /// Returns a value that is between `val1` and `val2`, interpolated by a `percent`.
    ///
    /// - parameter val1:    The lower bound of the interpolation.
    /// - parameter val2:    The upper bound of the interpolation.
    /// - parameter percent: The percentage between 0.0 - 1.0 used to interpolate the value.
    ///
    /// - returns: A new value of the same type, interpolated by `percent`.
    static func valueBetween(_ val1: Self, _ val2: Self, percent: Double) -> Self
}
