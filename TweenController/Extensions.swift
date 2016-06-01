//
//  Extensions.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/26/16.
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

import UIKit

extension TweenController {
    public func tweenFrom<T:Tweenable>(from: T, at progress: CGFloat) -> TweenPromise<T> {
        return tweenFrom(from, at: Double(progress))
    }
    
    public func observeForwardBoundary(progress: CGFloat, block: TweenObserverBlock) {
        observeForwardBoundary(Double(progress), block: block)
    }
    
    public func observeBackwardBoundary(progress: CGFloat, block: TweenObserverBlock) {
        observeBackwardBoundary(Double(progress), block: block)
    }
    
    public func observeBothBoundaries(progress: CGFloat, block: TweenObserverBlock) {
        observeBothBoundaries(Double(progress), block: block)
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
    
    public func to(to: T, at progress: CGFloat, withEasing easing: Easing.Function) -> TweenPromise<T> {
        return self.to(to, at: Double(progress), withEasing: easing)
    }
    
    public func thenTo(to: T, at progress: CGFloat, withEasing easing: Easing.Function) -> TweenPromise<T> {
        return thenTo(to, at: Double(progress), withEasing: easing)
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
        return { [weak self, weak scrollView] frame in
            guard let scrollView = scrollView else { return }
            self?.frame = frame.offsetBy(dx: scrollView.contentOffset.x, dy: scrollView.contentOffset.y)
        }
    }
    
    public func twc_applyCenter(center: CGPoint) {
        self.center = center
    }
    
    public func twc_applyTransform(transform: CGAffineTransform) {
        self.transform = transform
    }
    
    public func twc_applyAlpha(alpha: CGFloat) {
        self.alpha = alpha
    }
}

extension UIScrollView {
    public var twc_horizontalPageProgress: CGFloat {
        return contentOffset.x / bounds.width
    }
    
    public var twc_verticalPageProgress: CGFloat {
        return contentOffset.y / bounds.height
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
