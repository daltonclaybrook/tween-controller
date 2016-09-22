//
//  TweenController.swift
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

public typealias TweenObserverBlock = (_ progress: Double) -> ()

open class TweenController {
    
    open fileprivate(set) var progress: Double = 0.0
    fileprivate var descriptors = [TweenIntervalType]()
    fileprivate var boundaries = [Boundary]()
    
    //MARK: Public
    
    public init() {}
    
    open func tween<T:Tweenable>(_ from: T, at progress: Double) -> TweenPromise<T> {
        return TweenPromise(from: from, progress: progress, resolvedDescriptors: [], registration: self)
    }
    
    open func observeForward(_ progress: Double, block: @escaping TweenObserverBlock) {
        boundaries.append(Boundary(progress: progress, block: block, direction: .Forward))
    }
    
    open func observeBackward(_ progress: Double, block: @escaping TweenObserverBlock) {
        boundaries.append(Boundary(progress: progress, block: block, direction: .Backward))
    }
    
    open func observeBoth(_ progress: Double, block: @escaping TweenObserverBlock) {
        boundaries.append(Boundary(progress: progress, block: block, direction: .Both))
    }
    
    open func update(_ progress: Double) {
        let lastProgress = self.progress
        self.progress = progress
        updateDescriptors(progress)
        handleBoundaryCrossingIfNecessary(progress, lastProgress: lastProgress)
    }
    
    open func resetProgress() {
        progress = 0.0
        updateDescriptors(progress)
    }
    
    //MARK: Private
    
    fileprivate func updateDescriptors(_ progress: Double) {
        let filtered = descriptors.filter() { $0.containsProgress(progress) }
        filtered.forEach({ $0.handleProgressUpdate(progress) })
    }
    
    fileprivate func handleBoundaryCrossingIfNecessary(_ progress: Double, lastProgress: Double) {
        guard progress != lastProgress else { return }
        let direction: Boundary.Direction = progress > lastProgress ? .Forward : .Backward
        
        var boundaries = self.boundaries.filter() { $0.direction.contains(direction) }
        boundaries = boundaries.filter() { boundary in
            if direction == .Forward {
                return progress >= boundary.progress && lastProgress < boundary.progress
            } else {
                return lastProgress > boundary.progress && progress <= boundary.progress
            }
        }
        
        boundaries.forEach { $0.block(progress) }
    }
}

extension TweenController: DescriptorRegistration {
    
    func register<T : Tweenable>(_ descriptor: TweenDescriptor<T>) {
        descriptors.append(descriptor)
    }
    
    func observe(_ boundary: Boundary) {
        boundaries.append(boundary)
    }
}
