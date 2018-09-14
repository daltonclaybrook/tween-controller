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
