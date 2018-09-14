import Foundation

public protocol ObjectConvertible {
    func toObject() -> AnyObject
}

extension Int: ObjectConvertible {
    public func toObject() -> AnyObject {
        return self as AnyObject
    }
}

extension Float: ObjectConvertible {
    public func toObject() -> AnyObject {
        return self as AnyObject
    }
}

extension Double: ObjectConvertible {
    public func toObject() -> AnyObject {
        return self as AnyObject
    }
}

extension CGFloat: ObjectConvertible {
    public func toObject() -> AnyObject {
        return self as AnyObject
    }
}

extension TweenPromise where T: ObjectConvertible {

    /// Instead of using an action block with a tween operation, you can
    /// call this method to apply the value directly to an object using
    /// Key-Value-Coding. For example:
    ///
    ///     controller.tween(from: 0.0, at: 0.0)
    ///         .to(M_PI * 8.0, at: 1.0)
    ///         .with(object: tweenView.layer, keyPath: "transform.rotation.z")
    ///
    /// - parameter object:  The object to apply tweened values to.
    /// - parameter keyPath: The key-path on `object` used when applying tweened values.
    public func with(object: NSObject, keyPath: String) {
        with { [weak object] tweenable in
            object?.setValue(tweenable.toObject(), forKeyPath: keyPath)
        }
    }
}
