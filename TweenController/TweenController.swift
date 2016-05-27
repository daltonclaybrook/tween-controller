//
//  TweenController.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/9/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

public class TweenController {
    
    public private(set) var progress: Double = 0.0
    private var descriptors = [TweenIntervalType]()
    private var boundaries = [Boundary]()
    
    //MARK: Public
    
    public init() {}
    
    public func tweenFrom<T:Tweenable>(from: T, at progress: Double) -> TweenPromise<T> {
        return TweenPromise(from: from, progress: progress, resolvedDescriptors: []) { [weak self] descriptor in
            self?.registerDescriptor(descriptor)
        }
    }
    
    public func observeForwardBoundary(progress: Double, block: () -> ()) {
        boundaries.append(Boundary(progress: progress, block: block, direction: .Forward))
    }
    
    public func observeBackwardBoundary(progress: Double, block: () -> ()) {
        boundaries.append(Boundary(progress: progress, block: block, direction: .Backward))
    }
    
    public func observeBothBoundaries(progress: Double, block: () -> ()) {
        boundaries.append(Boundary(progress: progress, block: block, direction: .Both))
    }
    
    public func updateProgress(progress: Double) {
        let lastProgress = self.progress
        self.progress = progress
        updateDescriptorsWithProgress(progress)
        handleBoundaryCrossingIfNecessaryForProgress(progress, lastProgress: lastProgress)
    }
    
    public func resetProgress() {
        progress = 0.0
        updateDescriptorsWithProgress(progress)
    }
    
    //MARK: Private
    
    private func registerDescriptor(descriptor: TweenIntervalType) {
        descriptors.append(descriptor)
    }
    
    private func updateDescriptorsWithProgress(progress: Double) {
        let filtered = descriptors.filter() { $0.containsProgress(progress) }
        filtered.forEach({ $0.handleProgressUpdate(progress) })
    }
    
    private func handleBoundaryCrossingIfNecessaryForProgress(progress: Double, lastProgress: Double) {
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
        
        boundaries.forEach { $0.block() }
    }
}
