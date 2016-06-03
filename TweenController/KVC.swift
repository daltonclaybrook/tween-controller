//
//  KVC.swift
//  TweenController
//
//  Created by Dalton Claybrook on 6/1/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

import Foundation

public protocol ObjectConvertible {
    func toObject() -> AnyObject
}

extension Int: ObjectConvertible {
    public func toObject() -> AnyObject {
        return self
    }
}

extension Float: ObjectConvertible {
    public func toObject() -> AnyObject {
        return self
    }
}

extension Double: ObjectConvertible {
    public func toObject() -> AnyObject {
        return self
    }
}

extension CGFloat: ObjectConvertible {
    public func toObject() -> AnyObject {
        return self
    }
}

extension TweenPromise where T : ObjectConvertible {
    public func withObject(object: NSObject, keyPath: String) {
        addEdgeObservers()
        resolvedDescriptors.last?.isIntervalClosed = true
        resolvedDescriptors.forEach() { descriptor in
            descriptor.updateBlock = { [weak object] tweenable in
                object?.setValue(tweenable.toObject(), forKeyPath: keyPath)
            }
        }
    }
}

