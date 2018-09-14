import TweenController
import XCTest

class KeyPathTests: XCTestCase {

    let tweenController = TweenController()

    // MARK: - Tests

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
