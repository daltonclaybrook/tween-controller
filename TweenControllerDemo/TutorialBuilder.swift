//
//  TutorialBuilder.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/26/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

import UIKit
import TweenController

protocol TutorialViewController: class {
    var containerView: UIView! { get }
    var buttonsContainerView: UIView! { get }
    var pageControl: UIPageControl! { get }
}

struct TutorialBuilder {
    
    private static let starsSize = CGSize(width: 326, height: 462)
    
    //MARK: Public
    
    static func buildWithContainerViewController(viewController: TutorialViewController) -> (TweenController, UIScrollView) {
        let tweenController = TweenController()
        let scrollView = layoutViewsWithVC(viewController)
        describeBottomControlsWithVC(viewController, tweenController: tweenController, scrollView: scrollView)
        observeEndOfScrollView(viewController, tweenController: tweenController, scrollView: scrollView)
        describeBackgroundWithVC(viewController, tweenController: tweenController, scrollView: scrollView)
        
        return (tweenController, scrollView)
    }
    
    //MARK: Private
    //MARK: Initial Layout
    
    private static func layoutViewsWithVC(vc: TutorialViewController) -> UIScrollView {
        let scrollView = UIScrollView(frame: vc.containerView.bounds)
        guard let superview = vc.containerView.superview else { return scrollView }
        
        layoutButtonsAndPageControlWithVC(vc, scrollView: scrollView)
        
        superview.addSubview(scrollView)
        return scrollView
    }
    
    private static func layoutButtonsAndPageControlWithVC(vc: TutorialViewController, scrollView: UIScrollView) {
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
    }
    
    //MARK: Tutorial Actions
    
    private static func describeBottomControlsWithVC(vc: TutorialViewController, tweenController: TweenController, scrollView: UIScrollView) {
        let viewportSize = vc.containerView.frame.size
        let startingButtonFrame = vc.buttonsContainerView.frame
        let startingPageControlFrame = vc.pageControl.frame
        tweenController.tweenFrom(startingButtonFrame, at: -viewportSize.width)
            .to(startingButtonFrame, at: 0.0)
            .thenTo(CGRect(x: startingButtonFrame.minX, y: viewportSize.height, width: startingButtonFrame.width, height: startingButtonFrame.height), at: viewportSize.width)
            .thenHoldUntil(viewportSize.width * 4.0)
            .thenTo(startingButtonFrame, at: viewportSize.width * 5.0)
            .withAction(vc.buttonsContainerView.twc_slidingFrameActionWithScrollView(scrollView))
        
        let nextPageControlFrame = CGRect(x: startingPageControlFrame.minX, y: startingPageControlFrame.minY + startingButtonFrame.height, width: startingPageControlFrame.width, height: startingPageControlFrame.height)
        tweenController.tweenFrom(startingPageControlFrame, at: 0.0)
            .to(nextPageControlFrame, at: viewportSize.width)
            .thenHoldUntil(viewportSize.width * 4.0)
            .thenTo(startingPageControlFrame, at: viewportSize.width * 5.0)
            .withAction(vc.pageControl.twc_slidingFrameActionWithScrollView(scrollView))
    }
    
    private static func describeBackgroundWithVC(vc: TutorialViewController, tweenController: TweenController, scrollView: UIScrollView) {
        describeStarGradientWithVC(vc, tweenController: tweenController, scrollView: scrollView)
        describeStarsWithVC(vc, tweenController: tweenController, scrollView: scrollView)
        describeEiffelTowerWithVC(vc, tweenController: tweenController, scrollView: scrollView)
    }
    
    private static func describeStarGradientWithVC(vc: TutorialViewController, tweenController: TweenController, scrollView: UIScrollView) {
        let viewportFrame = CGRect(origin: CGPointZero, size: vc.containerView.frame.size)
        let topColor = UIColor(red: 155.0/255.0, green: 39.0/255.0, blue: 153.0/255.0, alpha: 1.0)
        let bottomColor = UIColor(red: 38.0/255.0, green: 198.0/255.0, blue: 218.0/255.0, alpha: 1.0)
        let gradientLayer = CAGradientLayer()
        let gradientView = UIView(frame: viewportFrame.offsetBy(dx: viewportFrame.width, dy: 0.0))
        
        gradientLayer.colors = [bottomColor.CGColor, topColor.CGColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.frame = viewportFrame
        gradientView.backgroundColor = UIColor.clearColor()
        gradientView.layer.addSublayer(gradientLayer)
        gradientView.alpha = 0.0
        scrollView.insertSubview(gradientView, belowSubview: vc.pageControl)
        
        tweenController.tweenFrom(viewportFrame, at: viewportFrame.width)
            .thenHoldUntil(viewportFrame.width * 3.0)
            .withAction(gradientView.twc_slidingFrameActionWithScrollView(scrollView))
        
        tweenController.tweenFrom(gradientView.alpha, at: viewportFrame.width)
            .to(1.0, at: viewportFrame.width * 2.0)
            .thenTo(0.0, at: viewportFrame.width * 3.0)
            .withAction(gradientView.twc_applyAlpha)
    }
    
    private static func describeStarsWithVC(vc: TutorialViewController, tweenController: TweenController, scrollView: UIScrollView) {
        let viewportSize = vc.containerView.frame.size
        let xOffset = (viewportSize.width-starsSize.width)/2.0
        let starsFrame = CGRect(x: xOffset, y: 0.0, width: starsSize.width, height: starsSize.height)
        let starsImageView = UIImageView(image: UIImage(named: "stars"))
        
        starsImageView.frame = starsFrame.offsetBy(dx: viewportSize.width, dy: 0.0)
        starsImageView.alpha = 0.0
        starsImageView.contentMode = .ScaleToFill
        scrollView.insertSubview(starsImageView, belowSubview: vc.pageControl)
        
        tweenController.tweenFrom(starsFrame, at: viewportSize.width)
            .thenHoldUntil(viewportSize.width * 3.0)
            .withAction(starsImageView.twc_slidingFrameActionWithScrollView(scrollView))
        
        tweenController.tweenFrom(starsImageView.alpha, at: viewportSize.width)
            .to(1.0, at: viewportSize.width * 2.0)
            .thenTo(0.0, at: viewportSize.width * 3.0)
            .withAction(starsImageView.twc_applyAlpha)
    }
    
    private static func describeEiffelTowerWithVC(vc: TutorialViewController, tweenController: TweenController, scrollView: UIScrollView) {
        let viewportFrame = CGRect(origin: CGPointZero, size: vc.containerView.frame.size)
        let imageView = UIImageView(image: UIImage(named: "eiffel_tower"))
        imageView.frame = viewportFrame.offsetBy(dx: viewportFrame.width * 2.0, dy: 0.0)
        imageView.alpha = 0.0
        scrollView.addSubview(imageView)
        
        tweenController.tweenFrom(viewportFrame, at: viewportFrame.width * 2.0)
            .thenHoldUntil(viewportFrame.width * 4.0)
            .withAction(imageView.twc_slidingFrameActionWithScrollView(scrollView))
        
        tweenController.tweenFrom(imageView.alpha, at: viewportFrame.width * 2.0)
            .to(1.0, at: viewportFrame.width * 3.0)
            .thenHoldUntil(viewportFrame.width * 4.0)
            .thenTo(0.0, at: viewportFrame.width * 5.0)
            .withAction(imageView.twc_applyAlpha)
    }
    
    //MARK: Observers
    
    private static func observeEndOfScrollView(vc: TutorialViewController, tweenController: TweenController, scrollView: UIScrollView) {
        let viewSize = vc.containerView.bounds.size
        tweenController.observeForwardBoundary(scrollView.contentSize.width - viewSize.width) { [weak scrollView, weak vc, weak tweenController] in
            scrollView?.contentOffset = CGPointZero
            tweenController?.resetProgress()
            vc?.pageControl.currentPage = 0
        }
    }
}
