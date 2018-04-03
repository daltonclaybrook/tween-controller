//
//  TweenDescriptor.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/9/16.
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

public protocol TweenIntervalType {
    var interval: Range<Double> { get }
    var easingFunction: Easing.Function { get }
    var isIntervalClosed: Bool { get set }
    func contains(progress: Double) -> Bool
    func handleProgressUpdate(_ progress: Double)
}

extension TweenIntervalType {
    public func contains(progress: Double) -> Bool {
        return interval.contains(progress) || (isIntervalClosed && interval.upperBound == progress)
    }
}

open class TweenDescriptor<T: Tweenable>: TweenIntervalType {
    
    open let fromValue: T
    open let toValue: T
    open let interval: Range<Double>
    open let easingFunction: Easing.Function
    open var isIntervalClosed: Bool = false
    open var updateBlock: ((T) -> ())?
    
    init(fromValue: T, toValue: T, interval: Range<Double>, easingFunction: @escaping Easing.Function) {
        self.fromValue = fromValue
        self.toValue = toValue
        self.interval = interval
        self.easingFunction = easingFunction
    }
    
    open func handleProgressUpdate(_ progress: Double) {
        guard let block = updateBlock, contains(progress: progress) else { return }
        let percent = percentFromProgress(progress)
        let easedPercent = easingFunction(percent)
        block(T.valueBetween(fromValue, toValue, percent: easedPercent))
    }
    
    //MARK: Private
    
    private func percentFromProgress(_ progress: Double) -> Double {
        return (progress - interval.lowerBound) / (interval.upperBound - interval.lowerBound)
    }
}
