//
//  Extensions.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/26/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

import UIKit

extension TweenController {
    public func tweenFrom<T:Tweenable>(from: T, at progress: CGFloat) -> TweenPromise<T> {
        return tweenFrom(from, at: Double(progress))
    }
    
    public func observeForwardBoundary(progress: CGFloat, block: () -> ()) {
        observeForwardBoundary(Double(progress), block: block)
    }
    
    public func observeBackwardBoundary(progress: CGFloat, block: () -> ()) {
        observeBackwardBoundary(Double(progress), block: block)
    }
    
    public func updateProgress(progress: CGFloat) {
        updateProgress(Double(progress))
    }
}

extension TweenPromise {
    public func to(to: T, at progress: CGFloat) -> TweenPromise<T> {
        return self.to(to, at: Double(progress))
    }
    
    public func thenTo(to: T, at progress: CGFloat) -> TweenPromise<T> {
        return thenTo(to, at: Double(progress))
    }
    
    public func thenHoldUntil(until: CGFloat) -> TweenPromise<T> {
        return thenHoldUntil(Double(until))
    }
}

extension UIView {
    public func twc_applyBackgroundColor(color: UIColor) {
        self.backgroundColor = color
    }
    
    public func twc_applyBounds(bounds: CGRect) {
        self.bounds = bounds
    }
    
    public func twc_applyFrame(frame: CGRect) {
        self.frame = frame
    }
    
    public func twc_slidingFrameActionWithScrollView(scrollView: UIScrollView) -> (frame: CGRect) -> () {
        return { [weak self, scrollView] frame in
            self?.frame = frame.offsetBy(dx: scrollView.contentOffset.x, dy: scrollView.contentOffset.y)
        }
    }
    
    public func twc_applyCenter(center: CGPoint) {
        self.center = center
    }
    
    public func twc_applyTransform(transform: CGAffineTransform) {
        self.transform = transform
    }
}

extension CALayer {
    public func twc_applyTransform(transform: CATransform3D) {
        self.transform = transform
    }
    
    public func twc_applyAffineTransform(transform: CGAffineTransform) {
        self.setAffineTransform(transform)
    }
}
