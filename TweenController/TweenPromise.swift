//
//  TweenPromise.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/11/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

protocol DescriptorRegistration: class {
    func registerDescriptor<T: Tweenable>(descriptor: TweenDescriptor<T>)
    func observeBoundary(boundary: Boundary)
}

public struct TweenPromise<T:Tweenable> {
    let from: T
    let progress: Double
    let resolvedDescriptors: [TweenDescriptor<T>]
    weak var registration: DescriptorRegistration?
    
    public func to(to: T, at progress: Double) -> TweenPromise<T> {
        assert(progress != self.progress, "'to' progress must be different than 'from' progress")
        
        let descriptor = TweenDescriptor(fromValue: from, toValue: to, interval: self.progress..<progress)
        registration?.registerDescriptor(descriptor)
        return TweenPromise(from: to, progress: progress, resolvedDescriptors: resolvedDescriptors + [descriptor], registration: registration)
    }
    
    public func thenTo(to: T, at progress: Double) -> TweenPromise<T> {
        return self.to(to, at: progress)
    }
    
    public func thenHoldUntil(until: Double) -> TweenPromise<T> {
        return self.to(from, at: until)
    }
    
    public func withAction(block: (T) -> ()) {
        addEdgeObservers()
        resolvedDescriptors.last?.isIntervalClosed = true
        resolvedDescriptors.forEach() { $0.updateBlock = block }
    }
    
    //MARK: Private
    
    private func addEdgeObservers() {
        guard let first = resolvedDescriptors.first, last = resolvedDescriptors.last else { return }
        let firstProgress = first.interval.start
        let lastProgress = last.interval.end
        
        // if we're exiting the interval, update the progress to the edges
        registration?.observeBoundary(Boundary(progress: firstProgress, block: { [weak first] progress in
            guard let first = first else { return }
            if !first.containsProgress(progress) || firstProgress == progress {
                first.handleProgressUpdate(firstProgress)
            }
        }, direction: .Both))
        registration?.observeBoundary(Boundary(progress: lastProgress, block: { [weak last] progress in
            guard let last = last else { return }
            if !last.containsProgress(progress) || progress == lastProgress {
                last.handleProgressUpdate(lastProgress)
            }
        }, direction: .Both))
    }
}
