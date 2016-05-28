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
    private static let baselineScreenWidth: CGFloat = 414
    private static let baselineCardViewHeight: CGFloat = 496
    private static let cardYOffset: CGFloat = 186.0
    private static let cardYTranslation: CGFloat = -28.0
    
    //MARK: Public
    
    static func buildWithContainerViewController(viewController: TutorialViewController) -> (TweenController, UIScrollView) {
        let tweenController = TweenController()
        let scrollView = layoutViewsWithVC(viewController)
        describeBottomControlsWithVC(viewController, tweenController: tweenController, scrollView: scrollView)
        observeEndOfScrollView(viewController, tweenController: tweenController, scrollView: scrollView)
        describeBackgroundWithVC(viewController, tweenController: tweenController, scrollView: scrollView)
        describeTextWithVC(viewController, tweenController: tweenController, scrollView: scrollView)
        describeCardTextWithVC(viewController, tweenController: tweenController, scrollView: scrollView)
        describeCardImageWithVC(viewController, tweenController: tweenController, scrollView: scrollView)
        describeCardFacesWithVC(viewController, tweenController: tweenController, scrollView: scrollView)
        
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
        tweenController.tweenFrom(startingButtonFrame, at: -1.0)
            .to(startingButtonFrame, at: 0.0)
            .thenTo(CGRect(x: startingButtonFrame.minX, y: viewportSize.height, width: startingButtonFrame.width, height: startingButtonFrame.height), at: 1.0)
            .thenHoldUntil(4.0)
            .thenTo(startingButtonFrame, at: 5.0)
            .withAction(vc.buttonsContainerView.twc_slidingFrameActionWithScrollView(scrollView))
        
        let nextPageControlFrame = CGRect(x: startingPageControlFrame.minX, y: startingPageControlFrame.minY + startingButtonFrame.height, width: startingPageControlFrame.width, height: startingPageControlFrame.height)
        tweenController.tweenFrom(startingPageControlFrame, at: 0.0)
            .to(nextPageControlFrame, at: 1.0)
            .thenHoldUntil(4.0)
            .thenTo(startingPageControlFrame, at: 5.0)
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
        
        tweenController.tweenFrom(viewportFrame, at: 1.0)
            .thenHoldUntil(3.0)
            .withAction(gradientView.twc_slidingFrameActionWithScrollView(scrollView))
        
        tweenController.tweenFrom(gradientView.alpha, at: 1.0)
            .to(1.0, at: 2.0)
            .thenTo(0.0, at: 3.0)
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
        
        tweenController.tweenFrom(starsFrame, at: 1.0)
            .thenHoldUntil(3.0)
            .withAction(starsImageView.twc_slidingFrameActionWithScrollView(scrollView))
        
        tweenController.tweenFrom(starsImageView.alpha, at: 1.0)
            .to(1.0, at: 2.0)
            .thenTo(0.0, at: 3.0)
            .withAction(starsImageView.twc_applyAlpha)
    }
    
    private static func describeEiffelTowerWithVC(vc: TutorialViewController, tweenController: TweenController, scrollView: UIScrollView) {
        let viewportFrame = CGRect(origin: CGPointZero, size: vc.containerView.frame.size)
        let imageView = UIImageView(image: UIImage(named: "eiffel_tower"))
        imageView.frame = viewportFrame.offsetBy(dx: viewportFrame.width * 2.0, dy: 0.0)
        imageView.alpha = 0.0
        scrollView.addSubview(imageView)
        
        tweenController.tweenFrom(viewportFrame, at: 2.0)
            .thenHoldUntil(4.0)
            .withAction(imageView.twc_slidingFrameActionWithScrollView(scrollView))
        
        tweenController.tweenFrom(imageView.alpha, at: 2.0)
            .to(1.0, at: 3.0)
            .thenHoldUntil(4.0)
            .thenTo(0.0, at: 5.0)
            .withAction(imageView.twc_applyAlpha)
    }
    
    private static func describeTextWithVC(vc: TutorialViewController, tweenController: TweenController, scrollView: UIScrollView) {
        let viewportFrame = CGRect(origin: CGPointZero, size: vc.containerView.frame.size)
        let multiplier = viewportFrame.width / baselineScreenWidth
        let topYOffset = 50 * multiplier
        let bottomYOffset = 80 * multiplier
        
        let topView1 = UIImageView(image: UIImage(named: "top_copy_s2"))
        let topView2 = UIImageView(image: UIImage(named: "top_copy_s3"))
        let topView3 = UIImageView(image: UIImage(named: "top_copy_s4"))
        let topView4 = UIImageView(image: UIImage(named: "top_copy_s5"))
        
        let bottomView1 = UIImageView(image: UIImage(named: "bottom_copy_s2"))
        let bottomView2 = UIImageView(image: UIImage(named: "bottom_copy_s3"))
        let bottomView3 = UIImageView(image: UIImage(named: "bottom_copy_s4"))
        let bottomView4 = UIImageView(image: UIImage(named: "bottom_copy_s5"))
        
        let bottomViews = [bottomView1, bottomView2, bottomView3, bottomView4]
        for i in 0..<bottomViews.count {
            let view = bottomViews[i]
            let size = CGSize(width: view.image!.size.width * multiplier, height: view.image!.size.height * multiplier)
            let xOffset = (viewportFrame.width - size.width) / 2.0
            view.frame = CGRect(x: CGFloat(i + 1) * viewportFrame.width + xOffset, y: bottomYOffset, width: size.width, height: size.height)
            scrollView.addSubview(view)
        }
        
        tweenController.tweenFrom(bottomView4.alpha, at: 3.0)
            .thenHoldUntil(4.0)
            .thenTo(0.0, at: 5.0)
            .withAction(bottomView4.twc_applyAlpha)
        
        let topViews = [topView1, topView2, topView3, topView4]
        for i in 0..<topViews.count {
            let view = topViews[i]
            let size = CGSize(width: view.image!.size.width * multiplier, height: view.image!.size.height * multiplier)
            let xOffset = (viewportFrame.width - size.width) / 2.0 + viewportFrame.width
            view.frame = CGRect(x: xOffset, y: topYOffset, width: size.width, height: size.height)
            scrollView.addSubview(view)
            
            if i != 0 {
                view.alpha = 0.0
                let progress = CGFloat(i) + 0.5
                tweenController.tweenFrom(view.alpha, at: progress)
                    .to(1.0, at: progress + 0.5)
                    .thenTo(0.0, at: progress + 1.0)
                    .withAction(view.twc_applyAlpha)
            } else {
                tweenController.tweenFrom(view.alpha, at: 0.0)
                    .thenHoldUntil(1.0)
                    .thenTo(0.0, at: 1.5)
                    .withAction(view.twc_applyAlpha)
            }
            
            tweenController.tweenFrom(view.frame, at: 0.0)
                .to(view.frame.offsetBy(dx: -viewportFrame.width, dy: 0.0), at: 1.0)
                .thenHoldUntil(4.0)
                .withAction(view.twc_slidingFrameActionWithScrollView(scrollView))
        }
    }
    
    private static func describeCardTextWithVC(vc: TutorialViewController, tweenController: TweenController, scrollView: UIScrollView) {
        let viewportFrame = CGRect(origin: CGPointZero, size: vc.containerView.frame.size)
        let multiplier = viewportFrame.width / baselineScreenWidth
        
        // Text Box
        
        let textImage = UIImage(named: "message_bubble")
        let textView1 = UIImageView(image: textImage)
        let textView2 = UIImageView(image: textImage)
        
        scrollView.addSubview(textView1)
        scrollView.addSubview(textView2)
        
        let boxImageSize = CGSize(width: textImage!.size.width * multiplier, height: textImage!.size.height * multiplier)
        let cardImageSize = (UIImage(named: "sunrise")?.size).flatMap() { CGSize(width: $0.width * multiplier, height: $0.height * multiplier) }!
        let xOffset1 = 40.0 * multiplier + viewportFrame.width
        let xOffset2 = (viewportFrame.width - boxImageSize.width) / 2.0 + viewportFrame.width * 2.0
        let yOffset1 = -16.0 * multiplier + cardYOffset * multiplier + cardImageSize.height
        let yOffset2 = -16.0 * multiplier + cardYOffset * multiplier + cardYTranslation * multiplier + cardImageSize.height
        
        let frame1 = CGRect(x: xOffset1, y: yOffset1, width: boxImageSize.width, height: boxImageSize.height)
        let frame2 = CGRect(x: xOffset2, y: yOffset2, width: boxImageSize.width, height: boxImageSize.height)
        textView1.frame = frame1
        textView2.frame = frame2.offsetBy(dx: viewportFrame.width, dy: 0.0)
        
        tweenController.tweenFrom(frame1, at: 0.0)
            .thenHoldUntil(1.0)
            .thenTo(frame2, at: 2.0)
            .withAction(textView1.twc_applyFrame)
        
        // Box Contents
        
        let contentsView1 = UIImageView(image: UIImage(named: "card_copy_s2"))
        let contentsView2 = UIImageView(image: UIImage(named: "card_copy_s3"))
        let contentsView3 = UIImageView(image: UIImage(named: "card_copy_s4"))
        
        let contents1Size = CGSize(width: contentsView1.image!.size.width * multiplier, height: contentsView1.image!.size.height * multiplier)
        let contents2Size = CGSize(width: contentsView2.image!.size.width * multiplier, height: contentsView2.image!.size.height * multiplier)
        let contents3Size = CGSize(width: contentsView3.image!.size.width * multiplier, height: contentsView3.image!.size.height * multiplier)
        
        let yMod = -12.0 * multiplier
        contentsView1.frame = CGRect(x: (boxImageSize.width-contents1Size.width)/2.0, y: (boxImageSize.height-contents1Size.height)/2.0 + yMod, width: contents1Size.width, height: contents1Size.height)
        contentsView2.frame = CGRect(x: (boxImageSize.width-contents2Size.width)/2.0, y: (boxImageSize.height-contents2Size.height)/2.0 + yMod, width: contents2Size.width, height: contents2Size.height)
        contentsView3.frame = CGRect(x: (boxImageSize.width-contents3Size.width)/2.0, y: (boxImageSize.height-contents3Size.height)/2.0 + yMod, width: contents3Size.width, height: contents3Size.height)
        
        textView1.addSubview(contentsView1)
        textView1.addSubview(contentsView2)
        textView2.addSubview(contentsView3)
        
        contentsView2.alpha = 0.0
        
        tweenController.tweenFrom(contentsView1.alpha, at: 0.0)
            .thenHoldUntil(1.0)
            .thenTo(0.0, at: 2.0)
            .withAction(contentsView1.twc_applyAlpha)
        
        tweenController.tweenFrom(contentsView2.alpha, at: 0.0)
            .thenHoldUntil(1.0)
            .thenTo(1.0, at: 2.0)
            .withAction(contentsView2.twc_applyAlpha)
    }
    
    private static func describeCardImageWithVC(vc: TutorialViewController, tweenController: TweenController, scrollView: UIScrollView) {
        let viewportFrame = CGRect(origin: CGPointZero, size: vc.containerView.frame.size)
        let sunriseView = UIImageView(image: UIImage(named: "sunrise"))
        let birthdayView = UIImageView(image: UIImage(named: "birthday_cake"))
        let eiffelView = UIImageView(image: UIImage(named: "eiffel"))
        
        scrollView.addSubview(sunriseView)
        scrollView.addSubview(birthdayView)
        scrollView.addSubview(eiffelView)
        
        let multiplier = viewportFrame.width / baselineScreenWidth
        let imageSize = CGSize(width: sunriseView.image!.size.width * multiplier, height: sunriseView.image!.size.height * multiplier)
        let imageXOffset = (viewportFrame.width - imageSize.width) / 2.0
        let imageYOffset = cardYOffset * multiplier
        
        let frame1 = CGRect(x: viewportFrame.width + imageXOffset, y: imageYOffset, width: imageSize.width, height: imageSize.height)
        let frame2 = frame1.offsetBy(dx: viewportFrame.width, dy: cardYTranslation * multiplier)
        
        sunriseView.frame = frame1
        birthdayView.frame = frame1
        eiffelView.frame = frame2.offsetBy(dx: viewportFrame.width, dy: 0.0)
        
        tweenController.tweenFrom(frame1, at: 0.0)
            .thenHoldUntil(1.0)
            .thenTo(frame2, at: 2.0)
            .withAction(sunriseView.twc_applyFrame)
        
        tweenController.tweenFrom(frame1, at: 1.0)
            .to(frame2, at: 2.0)
            .withAction(birthdayView.twc_applyFrame)
        
        birthdayView.alpha = 0.0
        tweenController.tweenFrom(sunriseView.alpha, at: 0.0)
            .thenHoldUntil(1.0)
            .thenTo(0.0, at: 2.0)
            .withAction(sunriseView.twc_applyAlpha)
        
        tweenController.tweenFrom(birthdayView.alpha, at: 1.0)
            .to(1.0, at: 2.0)
            .withAction(birthdayView.twc_applyAlpha)
    }
    
    private static func describeCardFacesWithVC(vc: TutorialViewController, tweenController: TweenController, scrollView: UIScrollView) {
        let viewportFrame = CGRect(origin: CGPointZero, size: vc.containerView.frame.size)
        let multiplier = viewportFrame.width / baselineScreenWidth
    }
    
    //MARK: Observers
    
    private static func observeEndOfScrollView(vc: TutorialViewController, tweenController: TweenController, scrollView: UIScrollView) {
        tweenController.observeForwardBoundary(5.0) { [weak scrollView, weak vc, weak tweenController] _ in
            scrollView?.contentOffset = CGPointZero
            scrollView?.scrollEnabled = false
            scrollView?.scrollEnabled = true
            tweenController?.resetProgress()
            vc?.pageControl.currentPage = 0
        }
    }
}
