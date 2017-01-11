//
//  ExtensionsTests.swift
//  TweenController
//
//  Created by Dalton Claybrook on 1/10/17.
//  Copyright © 2017 Claybrook Software. All rights reserved.
//

import XCTest
import TweenController

class ExtensionsTests: XCTestCase {
    
    let tweenController = TweenController()
    
    //MARK: Tests
    
    func testApplyBackgroundColor() {
        let view = UIView()
        tweenController.tween(from: UIColor.green, at: 0.0)
            .to(.blue, at: 1.0)
            .with(action: view.twc_applyBackgroundColor)
        tweenController.update(progress: 0.5)
        
        let final = UIColor(red: 0.0, green: 0.5, blue: 0.5, alpha: 1.0)
        XCTAssertEqual(view.backgroundColor!, final)
    }
    
    func testApplyBounds() {
        let view = UIView()
        tweenController.tween(from: CGRect.zero, at: 0.0)
            .to(CGRect(x: 0.0, y: 0.0, width: 10, height: 10), at: 1.0)
            .with(action: view.twc_applyBounds)
        tweenController.update(progress: 0.5)
        
        XCTAssertEqual(view.bounds, CGRect(x: 0, y: 0, width: 5, height: 5))
    }
    
    func testApplyFrame() {
        let view = UIView()
        tweenController.tween(from: CGRect.zero, at: 0.0)
            .to(CGRect(x: 0.0, y: 0.0, width: 10, height: 10), at: 1.0)
            .with(action: view.twc_applyFrame)
        tweenController.update(progress: 0.5)
        
        XCTAssertEqual(view.frame, CGRect(x: 0, y: 0, width: 5, height: 5))
    }
    
    func testScrollViewSlidingFrame() {
        let scrollView = UIScrollView()
        let view = UIView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        scrollView.contentSize = CGSize(width: 500, height: 100) //5 pages
        view.frame = CGRect(x: 10, y: 10, width: 10, height: 10)
        scrollView.addSubview(view)
        
        tweenController.tween(from: view.frame, at: 0.0)
            .to(CGRect(x: 20, y: 20, width: 10, height: 10), at: 1.0)
            .with(action: view.twc_slidingFrameAction(scrollView: scrollView))
        
        scrollView.contentOffset = CGPoint(x: 200, y: 0)
        tweenController.update(progress: 0.5)
        
        //200 (offset) + 15 (tween)
        XCTAssertEqual(view.frame, CGRect(x: 215, y: 15, width: 10, height: 10))
    }
    
    func testApplyCenter() {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        
        tweenController.tween(from: view.center, at: 0.0)
            .to(CGPoint(x: 15, y: 15), at: 1.0)
            .with(action: view.twc_applyCenter)
        
        tweenController.update(progress: 0.5)
        XCTAssertEqual(view.center, CGPoint(x: 10, y: 10))
    }
    
    func testApplyTransform() {
        let view = UIView()
        view.frame = CGRect(x: 10, y: 10, width: 10, height: 10)
        view.transform = CGAffineTransform.identity
        
        tweenController.tween(from: view.transform, at: 0.0)
            .to(CGAffineTransform(scaleX: 2.0, y: 2.0), at: 1.0)
            .with(action: view.twc_applyTransform)
        
        tweenController.update(progress: 0.5)
        XCTAssertEqual(view.transform, CGAffineTransform(scaleX: 1.5, y: 1.5))
    }
    
    func testApplyAlpha() {
        let view = UIView()
        view.alpha = 1.0
        tweenController.tween(from: 1.0, at: 0.0)
            .to(0.0, at: 1.0)
            .with(action: view.twc_applyAlpha)
        
        tweenController.update(progress: 0.25)
        XCTAssertEqual(view.alpha, 0.75)
    }
    
    func testHorizontalPageProgress() {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        scrollView.contentSize = CGSize(width: 500, height: 100) //5 pages
        scrollView.contentOffset = CGPoint(x: 200, y: 0)
        
        XCTAssertEqual(scrollView.twc_horizontalPageProgress, 2.0)
    }
    
    func testVerticalPageProgress() {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        scrollView.contentSize = CGSize(width: 100, height: 500) //5 pages
        scrollView.contentOffset = CGPoint(x: 0, y: 200)
        
        XCTAssertEqual(scrollView.twc_verticalPageProgress, 2.0)
    }
    
    func testApplyLayerTransform() {
        let layer = CALayer()
        layer.frame = CGRect(x: 10, y: 10, width: 10, height: 10)
        layer.transform = CATransform3DIdentity
        
        tweenController.tween(from: CATransform3DIdentity, at: 0.0)
            .to(CATransform3DMakeScale(2.0, 2.0, 2.0), at: 1.0)
            .with(action: layer.twc_applyTransform)
        
        tweenController.update(progress: 0.5)
        XCTAssertTrue(CATransform3DEqualToTransform(layer.transform, CATransform3DMakeScale(1.5, 1.5, 1.5)))
    }
    
    func testApplyLayerAffineTransform() {
        let layer = CALayer()
        layer.frame = CGRect(x: 10, y: 10, width: 10, height: 10)
        layer.setAffineTransform(.identity)
        
        tweenController.tween(from: layer.affineTransform(), at: 0.0)
            .to(CGAffineTransform(scaleX: 2.0, y: 2.0), at: 1.0)
            .with(action: layer.twc_applyAffineTransform)
        
        tweenController.update(progress: 0.5)
        XCTAssertEqual(layer.affineTransform(), CGAffineTransform(scaleX: 1.5, y: 1.5))
    }
}
