//
//  TweenPromise.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/11/16.
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

protocol DescriptorRegistration: class {
    func register<T>(descriptor: TweenDescriptor<T>) where T: Tweenable
    func observe(boundary: Boundary)
}

/// `TweenPromise` is used to finish describing a tween operation after `tween(from: at:)` has been called on `TweenController`.
public struct TweenPromise<T: Tweenable> {
    let from: T
    let progress: Double
    let resolvedDescriptors: [TweenDescriptor<T>]
    weak var registration: DescriptorRegistration?
    
    /// Used to mark a 'key frame' of a tween operation.
    /// This will register a descriptor with the `TweenController` with the `to` value as the upper bound.
    ///
    /// - parameter to:       The `Tweenable` value to end a tweening operation on, such as a UIColor.
    /// - parameter progress: The progress point at which the tween will end.
    /// - parameter easing:   A function that can be used to apply an easing effect to the tween operation. Many easing functions are defined in `Easing.swift`.
    ///
    /// - returns: Another instance of `TweenPromise` used to register an additional tween operation.
    public func to(_ to: T, at progress: Double, withEasing easing: @escaping Easing.Function = Easing.linear) -> TweenPromise<T> {
        precondition(progress != self.progress, "'to' progress must be different than 'from' progress")
        
        let descriptor = TweenDescriptor(fromValue: from, toValue: to, interval: self.progress..<progress, easingFunction: easing)
        registration?.register(descriptor: descriptor)
        return TweenPromise(from: to, progress: progress, resolvedDescriptors: resolvedDescriptors + [descriptor], registration: registration)
    }
    
    /// Used to mark a 'key frame' of a tween operation.
    /// This will register a descriptor with the `TweenController` with the `to` value as the upper bound.
    /// Functionally equivalent to calling `to(...)`.
    ///
    /// - parameter to:       The `Tweenable` value to end a tweening operation on, such as a UIColor.
    /// - parameter progress: The progress point at which the tween will end.
    /// - parameter easing:   A function that can be used to apply an easing effect to the tween operation. Many easing functions are defined in `Easing.swift`.
    ///
    /// - returns: Another instance of `TweenPromise` used to register an additional tween operation.
    public func then(to: T, at progress: Double, withEasing easing: @escaping Easing.Function = Easing.linear) -> TweenPromise<T> {
        return self.to(to, at: progress, withEasing: easing)
    }
    
    /// Used to keep a value constant across two progress points.
    /// Functionally equivalent to calling `to(...)` and passing the previous 'key frame' value as the `to` value.
    ///
    /// - parameter until: The progress point at which the hold will end.
    ///
    /// - returns: Another instance of `TweenPromise` used to register an additional tween operation.
    public func thenHold(until: Double) -> TweenPromise<T> {
        return self.to(from, at: until)
    }
    
    /// Used to assign an action block to be executed in response to changes in any of the tween operations created by prior calls.
    ///
    /// - parameter action: The block which is executed when changes occur.
    public func with(action: @escaping (T) -> ()) {
        addEdgeObservers()
        resolvedDescriptors.last?.isIntervalClosed = true
        resolvedDescriptors.forEach() { $0.updateBlock = action }
    }
    
    //MARK: Private
    
    /// When progress crosses from inside to outside of a tween action interval,
    /// a final terminating action callback occurs using the edge progress value that was crossed over.
    private func addEdgeObservers() {
        guard let first = resolvedDescriptors.first, let last = resolvedDescriptors.last else { return }
        let firstProgress = first.interval.lowerBound
        let lastProgress = last.interval.upperBound
        
        // if we're exiting the interval, update the progress to the edges
        registration?.observe(boundary: Boundary(progress: firstProgress, block: { [weak first] progress in
            guard let first = first else { return }
            if !first.contains(progress: progress) || firstProgress == progress {
                first.handleProgressUpdate(firstProgress)
            }
        }, direction: .both))
        registration?.observe(boundary: Boundary(progress: lastProgress, block: { [weak last] progress in
            guard let last = last else { return }
            if !last.contains(progress: progress) || progress == lastProgress {
                last.handleProgressUpdate(lastProgress)
            }
        }, direction: .both))
    }
}
