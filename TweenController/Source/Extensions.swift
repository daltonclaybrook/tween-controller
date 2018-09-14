//
//  Extensions.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/26/16.
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

import UIKit

extension UIView {
    public func twc_applyBackgroundColor(_ color: UIColor) {
        self.backgroundColor = color
    }
    
    public func twc_applyBounds(_ bounds: CGRect) {
        self.bounds = bounds
    }
    
    public func twc_applyFrame(_ frame: CGRect) {
        self.frame = frame
    }
    
    /// This function can be used as the action block of a tween operation where the `Tweenable` type is `CGRect`.
    /// The rect passed to the block is offset by the scroll view's `contentOffset`, and thus, appears to be
    /// unaffected by the scrolling of the view, and acting as a 'sliding window.'
    ///
    /// - parameter scrollView: The scroll view used to offset the rect
    /// - returns: A block which can be used as the action block for a tween operation.
    public func twc_slidingFrameAction(scrollView: UIScrollView) -> (_ frame: CGRect) -> () {
        return { [weak self, weak scrollView] frame in
            guard let scrollView = scrollView else { return }
            self?.frame = frame.offsetBy(dx: scrollView.contentOffset.x, dy: scrollView.contentOffset.y)
        }
    }
    
    public func twc_applyCenter(_ center: CGPoint) {
        self.center = center
    }
    
    public func twc_applyTransform(_ transform: CGAffineTransform) {
        self.transform = transform
    }
    
    public func twc_applyAlpha(_ alpha: CGFloat) {
        self.alpha = alpha
    }
}

extension UIScrollView {
    
    /// Used to obtain the current horizontal 'page' value for the scroll view.
    ///
    /// For example, if the scroll view has been swiped three pages to the right and is being dragged halfway to the next page,
    /// this value will be 3.5.
    public var twc_horizontalPageProgress: CGFloat {
        return contentOffset.x / bounds.width
    }
    
    /// Used to obtain the current vertical 'page' value for the scroll view.
    ///
    /// For example, if the scroll view has been swiped three pages down and is being dragged halfway to the next page,
    /// this value will be 3.5.
    public var twc_verticalPageProgress: CGFloat {
        return contentOffset.y / bounds.height
    }
}

extension CALayer {
    public func twc_applyTransform(_ transform: CATransform3D) {
        self.transform = transform
    }
    
    public func twc_applyAffineTransform(_ transform: CGAffineTransform) {
        self.setAffineTransform(transform)
    }
}
