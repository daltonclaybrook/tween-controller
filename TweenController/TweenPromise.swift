//
//  TweenPromise.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/11/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

public struct TweenPromise<T:Tweenable> {
    let from: T
    let progress: Double
    let resolvedDescriptors: [TweenDescriptor<T>]
    let descriptorBlock: (TweenDescriptor<T>) -> ()
    
    public func to(to: T, at progress: Double) -> TweenPromise<T> {
        let descriptor = TweenDescriptor(fromValue: from, toValue: to, interval: self.progress..<progress)
        descriptorBlock(descriptor)
        return TweenPromise(from: to, progress: progress, resolvedDescriptors: resolvedDescriptors + [descriptor], descriptorBlock: descriptorBlock)
    }
    
    public func thenTo(to: T, at progress: Double) -> TweenPromise<T> {
        return self.to(to, at: progress)
    }
    
    public func thenHoldUntil(until: Double) -> TweenPromise<T> {
        return self.to(from, at: until)
    }
    
    public func withAction(block: (T) -> ()) {
        resolvedDescriptors.last?.isIntervalClosed = true
        resolvedDescriptors.forEach() { $0.updateBlock = block }
    }
}
