//
//  EasingTests.swift
//  TweenController
//
//  Created by Dalton Claybrook on 1/11/17.
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

class EasingTests: XCTestCase {
    
    let testValues = [0.25, 0.33, 0.5, 0.66, 0.75]
    
    //MARK: Tests
    
    //MARK: Linear
    
    func testLinear() {
        let expected = [0.25, 0.33000000000000002, 0.5, 0.66000000000000003, 0.75]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.linear))
    }
    
    //MARK: Quad
    
    func testEaseInQuad() {
        let expected = [0.0625, 0.10890000000000001, 0.25, 0.43560000000000004, 0.5625]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInQuad))
    }
    
    func testEaseOutQuad() {
        let expected = [0.4375, 0.55110000000000003, 0.75, 0.88439999999999996, 0.9375]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeOutQuad))
    }
    
    func testEaseInOutQuad() {
        let expected = [0.125, 0.21780000000000002, 0.5, 0.76880000000000004, 0.875]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInOutQuad))
    }
    
    //MARK: Cubic
    
    func testEaseInCubic() {
        let expected = [0.015625, 0.035937000000000004, 0.125, 0.28749600000000003, 0.421875]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInCubic))
    }
    
    func testEaseOutCubic() {
        let expected = [0.578125, 0.69923700000000011, 0.875, 0.96069599999999999, 0.984375]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeOutCubic))
    }
    
    func testEaseInOutCubic() {
        let expected = [0.0625, 0.14374800000000001, 0.5, 0.84278399999999998, 0.9375]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInOutCubic))
    }
    
    //MARK: Quart
    
    func testEaseInQuart() {
        let expected = [0.00390625, 0.011859210000000002, 0.0625, 0.18974736000000003, 0.31640625]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInQuart))
    }
    
    func testEaseOutQuart() {
        let expected = [-1.31640625, -1.2015112099999998, -1.0625, -1.01336336, -1.00390625]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeOutQuart))
    }
    
    func testEaseInOutQuart() {
        let expected = [0.03125, 0.094873680000000016, 0.5, 0.89309312000000007, 0.96875]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInOutQuart))
    }
    
    //MARK: Quint
    
    func testEaseInQuint() {
        let expected = [0.0009765625, 0.0039135393000000011, 0.03125, 0.12523325760000004, 0.2373046875]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInQuint))
    }
    
    func testEaseOutQuint() {
        let expected = [0.7626953125, 0.86498748930000002, 0.96875, 0.99545645760000001, 0.9990234375]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeOutQuint))
    }
    
    func testEaseInOutQuint() {
        let expected = [0.015625, 0.062616628800000018, 0.5, 0.92730332160000006, 0.984375]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInOutQuint))
    }
    
    //MARK: Sine
    
    func testEaseInSine() {
        let expected = [0.076120467488713262, 0.1313684855618088, 0.29289321881345243, 0.49095858424962868, 0.61731656763491016]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInSine))
    }
    
    func testEaseOutSine() {
        let expected = [0.38268343236508978, 0.4954586684324076, 0.70710678118654746, 0.86074202700394364, 0.92387953251128674]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeOutSine))
    }
    
    func testEaseInOutSine() {
        let expected = [0.14644660940672621, 0.24547929212481434, 0.49999999999999994, 0.74087683705085772, 0.85355339059327373]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInOutSine))
    }
    
    //MARK: Expo
    
    func testEaseInExpo() {
        let expected = [0.0055242717280199029, 0.0096183157292571639, 0.03125, 0.094732285406899916, 0.17677669529663689]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInExpo))
    }
    
    func testEaseOutExpo() {
        let expected = [0.82322330470336313, 0.89846845045547052, 0.96875, 0.98969134444708673, 0.99447572827198005]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeOutExpo))
    }
    
    func testEaseInOutExpo() {
        let expected = [0.015625, 0.047366142703449958, 0.5, 0.94559058979399224, 0.984375]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInOutExpo))
    }
    
    //MARK: Circ
    
    func testEaseInCirc() {
        let expected = [0.031754163448145745, 0.056019067989188653, 0.1339745962155614, 0.248734401160282, 0.33856217223385232]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInCirc))
    }
    
    func testEaseOutCirc() {
        let expected = [0.66143782776614768, 0.74236109811869866, 0.8660254037844386, 0.9404254356406998, 0.96824583655185426]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeOutCirc))
    }
    
    func testEaseInOutCirc() {
        let expected = [0.066987298107780702, 0.124367200580141, 0.5, 0.8666060555964672, 0.9330127018922193]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInOutCirc))
    }
    
    //MARK: Private
    
    func verify(expectedResults:[Double], of easingFunc: @escaping (Double)->(Double)) -> Bool {
        guard expectedResults.count == testValues.count else { return false }
        return zip(testValues, expectedResults).reduce(true) { $0 && (easingFunc($1.0) == $1.1) }
    }
}
