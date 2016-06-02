//
//  KVC.swift
//  TweenController
//
//  Created by Dalton Claybrook on 6/1/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

import Foundation

public protocol NumberConvertible {
    func toNumber() -> NSNumber
}

extension Int: NumberConvertible {
    public func toNumber() -> NSNumber {
        return self
    }
}

extension Float: NumberConvertible {
    public func toNumber() -> NSNumber {
        return self
    }
}

extension Double: NumberConvertible {
    public func toNumber() -> NSNumber {
        return self
    }
}

extension CGFloat: NumberConvertible {
    public func toNumber() -> NSNumber {
        return self
    }
}

extension TweenPromise where T : NumberConvertible {
    public func withObject(object: NSObject, keyPath: String) {
        addEdgeObservers()
        resolvedDescriptors.last?.isIntervalClosed = true
        resolvedDescriptors.forEach() { descriptor in
            descriptor.updateBlock = { [weak object] tweenable in
                object?.setValue(tweenable.toNumber(), forKeyPath: keyPath)
            }
        }
    }
}

