//
//  Easing.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/31/16.
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

/// A collection of easing functions beautifully demonstrated at http://gizma.com/easing/
public struct Easing {
    
    // t is a time value between 0.0 - 1.0
    // Return value is a value between 0.0 - 1.0 with the easing function applied
    public typealias Function = (_ t: Double) -> Double
    
    //MARK: Linear
    
    public static func linear(_ t: Double) -> Double {
        return t
    }
    
    //MARK: Quadratic
    
    public static func easeInQuad(_ t: Double) -> Double {
        return t * t
    }
    
    public static func easeOutQuad(_ t: Double) -> Double {
        return -t * (t - 2)
    }
    
    public static func easeInOutQuad(_ t: Double) -> Double {
        var _t = t / 0.5
        if _t < 1.0 {
            return 0.5 * _t * _t
        }
        _t -= 1.0
        return -0.5 * (_t * (_t - 2.0) - 1.0)
    }
    
    //MARK: Cubic
    
    public static func easeInCubic(_ t: Double) -> Double {
        return t * t * t
    }
    
    public static func easeOutCubic(_ t: Double) -> Double {
        let _t = t - 1.0
        return _t * _t * _t + 1
    }
    
    public static func easeInOutCubic(_ t: Double) -> Double {
        var _t = t / 0.5
        if _t < 1.0 {
            return 0.5 * _t * _t * _t
        }
        _t -= 2.0
        return 0.5 * (_t * _t * _t + 2.0)
    }
    
    //MARK: Quartic
    
    public static func easeInQuart(_ t: Double) -> Double {
        return t * t * t * t
    }
    
    public static func easeOutQuart(_ t: Double) -> Double {
        let _t = t - 1.0
        return -(_t * _t * _t * _t + 1)
    }
    
    public static func easeInOutQuart(_ t: Double) -> Double {
        var _t = t / 0.5
        if _t < 1.0 {
            return 0.5 * _t * _t * _t * _t
        }
        _t -= 2.0
        return -0.5 * (_t * _t * _t * _t - 2.0)
    }
    
    //MARK: Quintic
    
    public static func easeInQuint(_ t: Double) -> Double {
        return t * t * t * t * t
    }
    
    public static func easeOutQuint(_ t: Double) -> Double {
        let _t = t - 1.0
        return _t * _t * _t * _t * _t + 1
    }
    
    public static func easeInOutQuint(_ t: Double) -> Double {
        var _t = t / 0.5
        if _t < 1.0 {
            return 0.5 * _t * _t * _t * _t * _t
        }
        _t -= 2.0
        return 0.5 * (_t * _t * _t * _t * _t + 2.0)
    }
    
    //MARK: Sinusoidal
    
    public static func easeInSine(_ t: Double) -> Double {
        return -cos(t * (Double.pi/2.0)) + 1.0
    }
    
    public static func easeOutSine(_ t: Double) -> Double {
        return sin(t * (Double.pi/2.0))
    }
    
    public static func easeInOutSine(_ t: Double) -> Double {
        return -0.5 * (cos(Double.pi * t) - 1.0)
    }
    
    //MARK: Exponential
    
    public static func easeInExpo(_ t: Double) -> Double {
        return pow(2.0, 10.0 * (t - 1.0))
    }
    
    public static func easeOutExpo(_ t: Double) -> Double {
        return (-pow(2.0, -10.0 * t) + 1.0)
    }
    
    public static func easeInOutExpo(_ t: Double) -> Double {
        var _t = t / 0.5
        if _t < 1.0 {
            return 0.5 * pow(2.0, 10.0 * (_t - 1.0))
        }
        _t -= 1.0
        return 0.5 * (-pow(2.0, -10.0 * _t) + 2.0)
    }
    
    //MARK: Circular
    
    public static func easeInCirc(_ t: Double) -> Double {
        return -(sqrt(1.0 - t * t) - 1.0)
    }
    
    public static func easeOutCirc(_ t: Double) -> Double {
        let _t = t - 1.0
        return sqrt(1.0 - _t * _t)
    }
    
    public static func easeInOutCirc(_ t: Double) -> Double {
        var _t = t / 0.5
        if _t < 1.0 {
            return -0.5 * (sqrt(1.0 - _t * _t) - 1.0)
        }
        _t -= 2.0
        return 0.5 * (sqrt(1.0 - _t * _t) + 1.0)
    }
}
