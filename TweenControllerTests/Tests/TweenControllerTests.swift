import XCTest
import TweenController

class TweenControllerTests: XCTestCase {
    
    var tweenController = TweenController()
    
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
    
    func testTweenProgress_ThenHold() {
        var vals = [Double]()
        tweenController.tween(from: 0.0, at: 0.0)
            .to(0.5, at: 0.25)
            .thenHold(until: 0.75)
            .then(to: 1.0, at: 1.0)
            .with { val in
                vals.append(val)
        }
        tweenController.update(progress: 0.375)
        tweenController.update(progress: 0.875)
        
        XCTAssertEqual(vals[0], 0.5)
        XCTAssertEqual(vals[1], 0.75)
    }
    
    func testForwardBoundary() {
        var finalProgress = Double.nan
        var count = 0
        tweenController.observeForward(progress: 0.5) { (progress) in
            finalProgress = progress
            count += 1
        }
        tweenController.update(progress: 0.25)
        tweenController.update(progress: 0.75)
        tweenController.update(progress: 0.25)
        
        XCTAssertEqual(finalProgress, 0.75)
        XCTAssertEqual(count, 1)
    }
    
    func testBackwardBoundary() {
        var finalProgress = Double.nan
        var count = 0
        tweenController.observeBackward(progress: 0.5) { (progress) in
            finalProgress = progress
            count += 1
        }
        tweenController.update(progress: 0.25)
        tweenController.update(progress: 0.75)
        tweenController.update(progress: 0.25)
        
        XCTAssertEqual(finalProgress, 0.25)
        XCTAssertEqual(count, 1)
    }
    
    func testBothBoundaries() {
        var finalProgress = Double.nan
        var count = 0
        tweenController.observeBoth(progress: 0.5) { (progress) in
            finalProgress = progress
            count += 1
        }
        tweenController.update(progress: 0.25)
        tweenController.update(progress: 0.75)
        tweenController.update(progress: 0.25)
        
        XCTAssertEqual(finalProgress, 0.25)
        XCTAssertEqual(count, 2)
    }
    
    func testResetDoesNotFireBoundary() {
        var fired = false
        tweenController.observeBackward(progress: 0.5) { (progress) in
            fired = true
        }
        tweenController.update(progress: 0.25)
        tweenController.update(progress: 0.75)
        tweenController.resetProgress()
        
        XCTAssertEqual(tweenController.progress, 0.0)
        XCTAssertFalse(fired)
    }
    
    func testForwardEdgeObserver() {
        var vals = [Double]()
        tweenController.tween(from: 0.25, at: 0.25)
            .to(0.75, at: 0.75)
            .with { val in
                vals.append(val)
        }
        tweenController.update(progress: 0.5)
        tweenController.update(progress: 0.85)
        
        XCTAssertEqual(vals.count, 2)
        XCTAssertEqual(vals.last!, 0.75)
    }
    
    func testBackwardEdgeObserver() {
        var vals = [Double]()
        tweenController.tween(from: 0.25, at: 0.25)
            .to(0.75, at: 0.75)
            .with { val in
                vals.append(val)
        }
        tweenController.update(progress: 0.5)
        tweenController.update(progress: 0.15)
        
        XCTAssertEqual(vals.count, 2)
        XCTAssertEqual(vals.last!, 0.25)
    }
}
