//
//  TutorialBuilder.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/26/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

import UIKit
import TweenController

protocol TutorialViewController {
    var containerView: UIView! { get }
    var buttonsContainerView: UIView! { get }
    var pageControl: UIPageControl! { get }
}

struct TutorialBuilder {
    
    //MARK: Public
    
    static func buildWithContainerViewController(viewController: TutorialViewController) -> (TweenController, UIScrollView) {
        let tweenController = TweenController()
        let scrollView = layoutViewsWithVC(viewController)
        describeBottomControlsWithVC(viewController, tweenController: tweenController, scrollView: scrollView)
        
        return (tweenController, scrollView)
    }
    
    //MARK: Private
    
    private static func layoutViewsWithVC(vc: TutorialViewController) -> UIScrollView {
        let scrollView = UIScrollView(frame: vc.containerView.bounds)
        guard let superview = vc.containerView.superview else { return scrollView }
        let snapshot = vc.containerView.snapshotViewAfterScreenUpdates(true)
        
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        let viewSize = vc.containerView.bounds.size
        scrollView.contentSize = CGSizeMake(viewSize.width * 6.0, viewSize.height)
        vc.pageControl.numberOfPages = 5
        
        vc.containerView.translatesAutoresizingMaskIntoConstraints = true
        scrollView.addSubview(vc.containerView)
        
        let xOffset = scrollView.contentSize.width - viewSize.width
        snapshot.frame = vc.containerView.frame.offsetBy(dx: xOffset, dy: 0.0)
        scrollView.addSubview(snapshot)
        
        let buttonsFrame = vc.buttonsContainerView.convertRect(vc.buttonsContainerView.bounds, toView: scrollView)
        let pageControlFrame = vc.pageControl.convertRect(vc.pageControl.bounds, toView: scrollView)
        
        vc.buttonsContainerView.translatesAutoresizingMaskIntoConstraints = true
        vc.pageControl.translatesAutoresizingMaskIntoConstraints = true
        scrollView.addSubview(vc.buttonsContainerView)
        scrollView.addSubview(vc.pageControl)
        vc.buttonsContainerView.frame = buttonsFrame
        vc.pageControl.frame = pageControlFrame
        
        
        
        superview.addSubview(scrollView)
        return scrollView
    }
    
    private static func describeBottomControlsWithVC(vc: TutorialViewController, tweenController: TweenController, scrollView: UIScrollView) {
        
        let viewportSize = vc.containerView.frame.size
        let startingButtonFrame = vc.buttonsContainerView.frame
        let startingPageControlFrame = vc.pageControl.frame
        tweenController.tweenFrom(startingButtonFrame, at: 0.0)
            .to(CGRect(x: startingButtonFrame.minX, y: viewportSize.height, width: startingButtonFrame.width, height: startingButtonFrame.height), at: viewportSize.width)
            .thenHoldUntil(viewportSize.width * 5.0)
            .thenTo(startingButtonFrame, at: viewportSize.width * 6.0)
            .withAction(vc.buttonsContainerView.twc_slidingFrameActionWithScrollView(scrollView))
        
        let nextPageControlFrame = CGRect(x: startingPageControlFrame.minX, y: startingPageControlFrame.minY + startingButtonFrame.height, width: startingPageControlFrame.width, height: startingPageControlFrame.height)
        tweenController.tweenFrom(startingPageControlFrame, at: 0.0)
            .to(nextPageControlFrame, at: viewportSize.width)
            .thenHoldUntil(viewportSize.width * 5.0)
            .thenTo(startingPageControlFrame, at: viewportSize.width * 6.0)
            .withAction(vc.pageControl.twc_slidingFrameActionWithScrollView(scrollView))
    }
}
