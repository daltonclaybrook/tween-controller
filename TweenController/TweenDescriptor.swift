//
//  TweenDescriptor.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/9/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

public protocol TweenIntervalType {
    var interval: HalfOpenInterval<Double> { get }
    func containsProgress(progress: Double) -> Bool
    func handleProgressUpdate(progress: Double)
}

extension TweenIntervalType {
    public func containsProgress(progress: Double) -> Bool {
        return interval.contains(progress)
    }
}

public class TweenDescriptor<T:Tweenable>: TweenIntervalType {
    
    public let fromValue: T
    public let toValue: T
    public let interval: HalfOpenInterval<Double>
    public var updateBlock: ((T) -> ())?
    
    init(fromValue: T, toValue: T, interval: HalfOpenInterval<Double>) {
        self.fromValue = fromValue
        self.toValue = toValue
        self.interval = interval
    }
    
    public func handleProgressUpdate(progress: Double) {
        guard let block = updateBlock where interval.contains(progress) else { return }
        let percent = percentFromProgress(progress)
        block(T.valueBetween(fromValue, toValue, percent: percent))
    }
    
    //MARK: Private
    
    private func percentFromProgress(progress: Double) -> Double {
        return (progress - interval.start) / (interval.end - interval.start)
    }
}
