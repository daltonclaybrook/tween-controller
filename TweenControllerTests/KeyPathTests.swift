//
//  KeyPathTests.swift
//  TweenController
//
//  Created by Dalton Claybrook on 1/10/17.
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

import XCTest
import TweenController

class KeyPathTests: XCTestCase {
    
    let tweenController = TweenController()
    
    //MARK: Tests
    
    func testInt() {
        let listener = KeypathListener<Int>()
        tweenController.tween(from: 0, at: 0.0)
            .to(4, at: 1.0)
            .with(object: listener, keyPath: listener.keyPath)
        tweenController.update(progress: 0.75)
        
        XCTAssertEqual(listener.values.count, 1)
        XCTAssertEqual(listener.values[0], 3)
    }
    
    func testFloat() {
        let listener = KeypathListener<Float>()
        tweenController.tween(from: Float(0.0), at: 0.0)
            .to(1.0, at: 1.0)
            .with(object: listener, keyPath: listener.keyPath)
        tweenController.update(progress: 0.375)
        
        XCTAssertEqual(listener.values.count, 1)
        XCTAssertEqual(listener.values[0], 0.375)
    }
    
    func testDouble() {
        let listener = KeypathListener<Double>()
        tweenController.tween(from: 0.0, at: 0.0)
            .to(1.0, at: 1.0)
            .with(object: listener, keyPath: listener.keyPath)
        tweenController.update(progress: 0.375)
        
        XCTAssertEqual(listener.values.count, 1)
        XCTAssertEqual(listener.values[0], 0.375)
    }
    
    func testCGFloat() {
        let listener = KeypathListener<CGFloat>()
        tweenController.tween(from: CGFloat(0.0), at: 0.0)
            .to(1.0, at: 1.0)
            .with(object: listener, keyPath: listener.keyPath)
        tweenController.update(progress: 0.375)
        
        XCTAssertEqual(listener.values.count, 1)
        XCTAssertEqual(listener.values[0], 0.375)
    }
}
