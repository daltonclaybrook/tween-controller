//
//  TweenDescriptor.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/9/16.
//
//  Copyright (c) 2016 Dalton Claybrook
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

public protocol TweenIntervalType {
    var interval: HalfOpenInterval<Double> { get }
    var easingFunction: Easing.Function { get }
    var isIntervalClosed: Bool { get set }
    func containsProgress(progress: Double) -> Bool
    func handleProgressUpdate(progress: Double)
}

extension TweenIntervalType {
    public func containsProgress(progress: Double) -> Bool {
        if isIntervalClosed {
            return (interval.start...interval.end).contains(progress)
        } else {
            return interval.contains(progress)
        }
    }
}

public class TweenDescriptor<T:Tweenable>: TweenIntervalType {
    
    public let fromValue: T
    public let toValue: T
    public let interval: HalfOpenInterval<Double>
    public let easingFunction: Easing.Function
    public var isIntervalClosed: Bool = false
    public var updateBlock: ((T) -> ())?
    
    init(fromValue: T, toValue: T, interval: HalfOpenInterval<Double>, easingFunction: Easing.Function) {
        self.fromValue = fromValue
        self.toValue = toValue
        self.interval = interval
        self.easingFunction = easingFunction
    }
    
    public func handleProgressUpdate(progress: Double) {
        guard let block = updateBlock where containsProgress(progress) else { return }
        let percent = percentFromProgress(progress)
        let easedPercent = easingFunction(t: percent)
        block(T.valueBetween(fromValue, toValue, percent: easedPercent))
    }
    
    //MARK: Private
    
    private func percentFromProgress(progress: Double) -> Double {
        return (progress - interval.start) / (interval.end - interval.start)
    }
}
