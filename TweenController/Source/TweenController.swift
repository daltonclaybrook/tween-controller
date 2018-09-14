//
//  TweenController.swift
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

public typealias TweenObserverBlock = (_ progress: Double) -> ()

/// `TweenController` is the entry point into the framework.
///
///     let controller = TweenController()
///     controller.tween(from: transformA, at: 0.0)
///         .to(transformB, at: 0.5)
///         .then(to: transformC, at: 1.0)
///         .with(action: myView.layer.twc_applyAffineTransform)
open class TweenController {
    
    /// The current progress of the controller.
    /// The range of progress is completely arbitrary. 
    /// For example, you could use a percentage, i.e. 0.0 - 1.0, or the width of a scroll view in points.
    open private(set) var progress: Double = 0.0
    fileprivate var descriptors: [TweenIntervalType] = []
    fileprivate var boundaries: [Boundary] = []
    
    //MARK: Public
    
    public init() {}
    
    /// Used to begin describing a tween operation.
    ///
    /// - parameter from:     The `Tweenable` value to begin tweening from, such as a UIColor.
    /// - parameter progress: The progress point at which the tween will begin.
    ///
    /// - returns: A TweenPromise, which is used to continue (and ultimately finish) describing a tween operation.
    open func tween<T>(from: T, at progress: Double) -> TweenPromise<T> where T: Tweenable {
        return TweenPromise(from: from, progress: progress, resolvedDescriptors: [], registration: self)
    }
    
    /// Used to observe when `progress` crosses a boundary moving forward.
    ///
    /// - parameter progress: The boundary marker progress.
    /// - parameter block:    The block to execute with the boundary is crossed.
    open func observeForward(progress: Double, block: @escaping TweenObserverBlock) {
        boundaries.append(Boundary(progress: progress, block: block, direction: .forward))
    }
    
    /// Used to observe when `progress` crosses a boundary moving backward.
    ///
    /// - parameter progress: The boundary marker progress.
    /// - parameter block:    The block to execute with the boundary is crossed.
    open func observeBackward(progress: Double, block: @escaping TweenObserverBlock) {
        boundaries.append(Boundary(progress: progress, block: block, direction: .backward))
    }
    
    /// Used to observe when `progress` crosses a boundary moving in either direction.
    ///
    /// - parameter progress: The boundary marker progress.
    /// - parameter block:    The block to execute with the boundary is crossed.
    open func observeBoth(progress: Double, block: @escaping TweenObserverBlock) {
        boundaries.append(Boundary(progress: progress, block: block, direction: .both))
    }
    
    /// Used to update the `progress` of the `TweenController` and perform any actions necessary.
    ///
    /// **Note:** You should not use this method to reset progress back to 0.0 as it will call boundary observer blocks.
    /// Instead, call `resetProgress()`.
    ///
    /// - parameter progress: The new progress value.
    open func update(progress: Double) {
        let lastProgress = self.progress
        self.progress = progress
        updateDescriptors(progress: progress)
        handleBoundaryCrossingIfNecessary(progress: progress, lastProgress: lastProgress)
    }
    
    /// Resets the `progress` of the `TweenController` back to 0.0
    open func resetProgress() {
        progress = 0.0
        updateDescriptors(progress: progress)
    }
    
    //MARK: Private
    
    private func updateDescriptors(progress: Double) {
        let filtered = descriptors.filter() { $0.contains(progress: progress) }
        filtered.forEach { $0.handleProgressUpdate(progress) }
    }
    
    private func handleBoundaryCrossingIfNecessary(progress: Double, lastProgress: Double) {
        guard progress != lastProgress else { return }
        let direction: Boundary.Direction = progress > lastProgress ? .forward : .backward
        
        var boundaries = self.boundaries.filter() { $0.direction.contains(direction) }
        boundaries = boundaries.filter() { boundary in
            if direction == .forward {
                return progress >= boundary.progress && lastProgress < boundary.progress
            } else {
                return lastProgress > boundary.progress && progress <= boundary.progress
            }
        }
        
        boundaries.forEach { $0.block(progress) }
    }
}

extension TweenController: DescriptorRegistration {
    
    func register<T>(descriptor: TweenDescriptor<T>) where T: Tweenable {
        descriptors.append(descriptor)
    }
    
    func observe(boundary: Boundary) {
        boundaries.append(boundary)
    }
}
