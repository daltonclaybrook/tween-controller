//
//  TweenDescriptor.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/9/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

struct TweenDescriptor<T:Tweenable> {
    
    let fromValue: T
    let toValue: T
    let interval: ClosedInterval<Double>
    let thenBlock: (TweenDescriptor<T>) -> ()
    
    func then(value: T, progress: Double) -> TweenDescriptor<T> {
        let nextInterval = interval.end...progress
        let descriptor = TweenDescriptor(fromValue: toValue, toValue: value, interval: nextInterval, thenBlock: thenBlock)
        thenBlock(descriptor)
        return descriptor
    }
}
