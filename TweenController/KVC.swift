//
//  KVC.swift
//  TweenController
//
//  Created by Dalton Claybrook on 6/1/16.
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
