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
