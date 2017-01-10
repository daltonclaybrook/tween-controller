//
//  TweenControllerTests.swift
//  TweenControllerTests
//
//  Created by Dalton Claybrook on 1/9/17.
//  Copyright © 2017 Claybrook Software. All rights reserved.
//

import XCTest
import TweenController

class TweenControllerTests: XCTestCase {
    
    var tweenController = TweenController()
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK: Tests
    
    func testTweenProgress_To() {
        var finalVal = Double.nan
        tweenController.tween(from: 0.0, at: 0.0)
            .to(1.0, at: 1.0)
            .with { val in
                finalVal = val
        }
        tweenController.update(progress: 0.5)
        XCTAssertEqual(0.5, finalVal)
    }
    
    func testTweenProgress_Then() {
        var vals = [Double]()
        tweenController.tween(from: 0.0, at: 0.0)
            .to(0.25, at: 0.5)
            .then(to: 1.0, at: 1.0)
            .with { val in
                vals.append(val)
        }
        tweenController.update(progress: 0.25)
        tweenController.update(progress: 0.75)
        
        XCTAssertEqual(vals.count, 2)
        XCTAssertEqual(vals[0], 0.125)
        XCTAssertEqual(vals[1], 0.625)
    }
}

//MARK: Helpers
extension TweenControllerTests {
    
}
