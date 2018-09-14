//swiftlint:disable identifier_name

/// A collection of easing functions beautifully demonstrated at http://gizma.com/easing/
public struct Easing {
    // t is a time value between 0.0 - 1.0
    // Return value is a value between 0.0 - 1.0 with the easing function applied
    public typealias Function = (_ t: Double) -> Double

    // MARK: - Linear

    public static func linear(_ t: Double) -> Double {
        return t
    }

    // MARK: - Quadratic

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

    // MARK: - Cubic

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

    // MARK: - Quartic

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

    // MARK: - Quintic

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

    // MARK: - Sinusoidal

    public static func easeInSine(_ t: Double) -> Double {
        return -cos(t * (Double.pi / 2.0)) + 1.0
    }

    public static func easeOutSine(_ t: Double) -> Double {
        return sin(t * (Double.pi / 2.0))
    }

    public static func easeInOutSine(_ t: Double) -> Double {
        return -0.5 * (cos(Double.pi * t) - 1.0)
    }

    // MARK: - Exponential

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

    // MARK: - Circular

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
