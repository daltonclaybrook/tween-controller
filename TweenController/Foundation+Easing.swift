//
//  Foundation+Easing.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/31/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

import Foundation

extension Easing {
    
    // Sinusoidal
    
    static func easeInSine(t: Double) -> Double {
        return -cos(t * M_PI_2) + 1.0
    }
    
    static func easeOutSine(t: Double) -> Double {
        return sin(t * M_PI_2)
    }
    
    static func easeInOutSine(t: Double) -> Double {
        return -0.5 * (cos(M_PI * t) - 1.0)
    }
    
    // Exponential
    
    static func easeInExpo(t: Double) -> Double {
        return pow(2.0, 10.0 * (t - 1.0))
    }
    
    static func easeOutExpo(t: Double) -> Double {
        return (-pow(2.0, -10.0 * t) + 1.0)
    }
    
    static func easeInOutExpo(t: Double) -> Double {
        var _t = t / 0.5
        if _t < 1.0 {
            return 0.5 * pow(2.0, 10.0 * (_t - 1.0))
        }
        _t -= 1.0
        return 0.5 * (-pow(2.0, -10.0 * _t) + 2.0)
    }
    
    // Circular
    
    static func easeInCirc(t: Double) -> Double {
        return -(sqrt(1.0 - t * t) - 1.0)
    }
    
    static func easeOutCirc(t: Double) -> Double {
        let _t = t - 1.0
        return sqrt(1.0 - _t * _t)
    }
    
    static func easeInOutCirc(t: Double) -> Double {
        var _t = t / 0.5
        if _t < 1.0 {
            return -0.5 * (sqrt(1.0 - _t * _t) - 1.0)
        }
        _t -= 2.0
        return 0.5 * (sqrt(1.0 - _t * _t) + 1.0)
    }
}