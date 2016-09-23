//
//  TweenPromise.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/11/16.
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

protocol DescriptorRegistration: class {
    func register<T: Tweenable>(descriptor: TweenDescriptor<T>)
    func observe(boundary: Boundary)
}

public struct TweenPromise<T:Tweenable> {
    let from: T
    let progress: Double
    let resolvedDescriptors: [TweenDescriptor<T>]
    weak var registration: DescriptorRegistration?
    
    public func to(_ to: T, at progress: Double, withEasing easing: @escaping Easing.Function = Easing.linear) -> TweenPromise<T> {
        assert(progress != self.progress, "'to' progress must be different than 'from' progress")
        
        let descriptor = TweenDescriptor(fromValue: from, toValue: to, interval: self.progress..<progress, easingFunction: easing)
        registration?.register(descriptor: descriptor)
        return TweenPromise(from: to, progress: progress, resolvedDescriptors: resolvedDescriptors + [descriptor], registration: registration)
    }
    
    public func then(to: T, at progress: Double, withEasing easing: @escaping Easing.Function = Easing.linear) -> TweenPromise<T> {
        return self.to(to, at: progress, withEasing: easing)
    }
    
    public func thenHold(until: Double) -> TweenPromise<T> {
        return self.to(from, at: until)
    }
    
    public func with(action: @escaping (T) -> ()) {
        addEdgeObservers()
        resolvedDescriptors.last?.isIntervalClosed = true
        resolvedDescriptors.forEach() { $0.updateBlock = action }
    }
    
    //MARK: Private
    
    fileprivate func addEdgeObservers() {
        guard let first = resolvedDescriptors.first, let last = resolvedDescriptors.last else { return }
        let firstProgress = first.interval.lowerBound
        let lastProgress = last.interval.upperBound
        
        // if we're exiting the interval, update the progress to the edges
        registration?.observe(boundary: Boundary(progress: firstProgress, block: { [weak first] progress in
            guard let first = first else { return }
            if !first.contains(progress: progress) || firstProgress == progress {
                first.handleProgressUpdate(firstProgress)
            }
        }, direction: .Both))
        registration?.observe(boundary: Boundary(progress: lastProgress, block: { [weak last] progress in
            guard let last = last else { return }
            if !last.contains(progress: progress) || progress == lastProgress {
                last.handleProgressUpdate(lastProgress)
            }
        }, direction: .Both))
    }
}
