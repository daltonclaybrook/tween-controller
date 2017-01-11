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
}
