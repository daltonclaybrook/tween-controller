//
//  Easing.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/31/16.
//
//  Copyright (c) 2016 Dalton Claybrook
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

public struct Easing {
    
    // t is a time value between 0.0 - 1.0
    // Return value is a value between 0.0 - 1.0 with the easing function applied
    public typealias Function = (t: Double) -> Double
    
    // Linear
    
    public static func linear(t: Double) -> Double {
        return t
    }
    
    // Quadratic
    
    public static func easeInQuad(t: Double) -> Double {
        return t * t
    }
    
    public static func easeOutQuad(t: Double) -> Double {
        return -t * (t - 2)
    }
    
    public static func easeInOutQuad(t: Double) -> Double {
        var _t = t / 0.5
        if _t < 1.0 {
            return 0.5 * _t * _t
        }
        _t -= 1.0
        return -0.5 * (_t * (_t - 2.0) - 1.0)
    }
    
    // Cubic
    
    public static func easeInCubic(t: Double) -> Double {
        return t * t * t
    }
    
    public static func easeOutCubic(t: Double) -> Double {
        let _t = t - 1.0
        return _t * _t * _t + 1
    }
    
    public static func easeInOutCubic(t: Double) -> Double {
        var _t = t / 0.5
        if _t < 1.0 {
            return 0.5 * _t * _t * _t
        }
        _t -= 2.0
        return 0.5 * (_t * _t * _t + 2.0)
    }
    
    // Quartic
    
    public static func easeInQuart(t: Double) -> Double {
        return t * t * t * t
    }
    
    public static func easeOutQuart(t: Double) -> Double {
        let _t = t - 1.0
        return -(_t * _t * _t * _t + 1)
    }
    
    public static func easeInOutQuart(t: Double) -> Double {
        var _t = t / 0.5
        if _t < 1.0 {
            return 0.5 * _t * _t * _t * _t
        }
        _t -= 2.0
        return -0.5 * (_t * _t * _t * _t - 2.0)
    }
    
    // Quintic
    
    public static func easeInQuint(t: Double) -> Double {
        return t * t * t * t * t
    }
    
    public static func easeOutQuint(t: Double) -> Double {
        let _t = t - 1.0
        return _t * _t * _t * _t * _t + 1
    }
    
    public static func easeInOutQuint(t: Double) -> Double {
        var _t = t / 0.5
        if _t < 1.0 {
            return 0.5 * _t * _t * _t * _t * _t
        }
        _t -= 2.0
        return 0.5 * (_t * _t * _t * _t * _t + 2.0)
    }
}
