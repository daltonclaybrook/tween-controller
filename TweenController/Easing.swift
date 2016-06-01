//
//  Easing.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/31/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

struct Easing {
    
    // Linear
    
    static func linear(t: Double) -> Double {
        return t
    }
    
    // Quadratic
    
    static func easeInQuad(t: Double) -> Double {
        return t * t
    }
    
    static func easeOutQuad(t: Double) -> Double {
        return -t * (t - 2)
    }
    
    static func easeInOutQuad(t: Double) -> Double {
        var _t = t / 0.5
        if _t < 1.0 {
            return 0.5 * _t * _t
        }
        _t -= 1.0
        return -0.5 * (_t * (_t - 2.0) - 1.0)
    }
    
    // Cubic
    
    static func easeInCubic(t: Double) -> Double {
        return t * t * t
    }
    
    static func easeOutCubic(t: Double) -> Double {
        let _t = t - 1.0
        return _t * _t * _t + 1
    }
    
    static func easeInOutCubic(t: Double) -> Double {
        var _t = t / 0.5
        if _t < 1.0 {
            return 0.5 * _t * _t * _t
        }
        _t -= 2.0
        return 0.5 * (_t * _t * _t + 2.0)
    }
    
    // Quartic
    
    static func easeInQuart(t: Double) -> Double {
        return t * t * t * t
    }
    
    static func easeOutQuart(t: Double) -> Double {
        let _t = t - 1.0
        return -(_t * _t * _t * _t + 1)
    }
    
    static func easeInOutQuart(t: Double) -> Double {
        var _t = t / 0.5
        if _t < 1.0 {
            return 0.5 * _t * _t * _t * _t
        }
        _t -= 2.0
        return -0.5 * (_t * _t * _t * _t - 2.0)
    }
    
    // Quintic
    
    static func easeInQuint(t: Double) -> Double {
        return t * t * t * t * t
    }
    
    static func easeOutQuint(t: Double) -> Double {
        let _t = t - 1.0
        return _t * _t * _t * _t * _t + 1
    }
    
    static func easeInOutQuint(t: Double) -> Double {
        var _t = t / 0.5
        if _t < 1.0 {
            return 0.5 * _t * _t * _t * _t * _t
        }
        _t -= 2.0
        return 0.5 * (_t * _t * _t * _t * _t + 2.0)
    }
}
