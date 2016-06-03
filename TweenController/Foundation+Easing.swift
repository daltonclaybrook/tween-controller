//
//  Foundation+Easing.swift
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

import Foundation

public extension Easing {
    
    // Sinusoidal
    
    public static func easeInSine(t: Double) -> Double {
        return -cos(t * M_PI_2) + 1.0
    }
    
    public static func easeOutSine(t: Double) -> Double {
        return sin(t * M_PI_2)
    }
    
    public static func easeInOutSine(t: Double) -> Double {
        return -0.5 * (cos(M_PI * t) - 1.0)
    }
    
    // Exponential
    
    public static func easeInExpo(t: Double) -> Double {
        return pow(2.0, 10.0 * (t - 1.0))
    }
    
    public static func easeOutExpo(t: Double) -> Double {
        return (-pow(2.0, -10.0 * t) + 1.0)
    }
    
    public static func easeInOutExpo(t: Double) -> Double {
        var _t = t / 0.5
        if _t < 1.0 {
            return 0.5 * pow(2.0, 10.0 * (_t - 1.0))
        }
        _t -= 1.0
        return 0.5 * (-pow(2.0, -10.0 * _t) + 2.0)
    }
    
    // Circular
    
    public static func easeInCirc(t: Double) -> Double {
        return -(sqrt(1.0 - t * t) - 1.0)
    }
    
    public static func easeOutCirc(t: Double) -> Double {
        let _t = t - 1.0
        return sqrt(1.0 - _t * _t)
    }
    
    public static func easeInOutCirc(t: Double) -> Double {
        var _t = t / 0.5
        if _t < 1.0 {
            return -0.5 * (sqrt(1.0 - _t * _t) - 1.0)
        }
        _t -= 2.0
        return 0.5 * (sqrt(1.0 - _t * _t) + 1.0)
    }
}
