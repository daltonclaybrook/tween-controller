import TweenController
import UIKit

class ViewController: UIViewController {
    let controller = TweenController()

    @IBOutlet private var tweenView: UIView!

    private var timesFired: Int = 0
    private var displayLink: CADisplayLink!

    override func viewDidLoad() {
        super.viewDidLoad()

        tweenTransform()
        tweenColor()
        displayLink = CADisplayLink(target: self, selector: #selector(ViewController.timerFired(_:)))
        displayLink.add(to: RunLoop.main, forMode: RunLoopMode(rawValue: RunLoopMode.commonModes.rawValue))
    }

    // MARK: - Private

    @objc
    private func timerFired(_ timer: Timer) {
        timesFired += 1
        controller.update(progress: Double(timesFired) * 0.002_5)
        if controller.progress >= 1.0 {
            self.displayLink.invalidate()
            self.displayLink = nil
        }
    }

    private func tweenTransform() {
        controller.tween(from: 0.0, at: 0.0)
            .to(Double.pi * 8.0, at: 1.0, withEasing: Easing.easeInOutQuint)
            .with(object: tweenView.layer, keyPath: "transform.rotation.z")

        controller.tween(from: 1.0, at: 0.0)
            .to(2.0, at: 0.5)
            .then(to: 1.0, at: 1.0)
            .with { [weak self] scale in
                self?.tweenView.layer.setValue(scale, forKeyPath: "transform.scale.x")
                self?.tweenView.layer.setValue(scale, forKeyPath: "transform.scale.y")
            }
    }

    private func tweenColor() {
        let colorA = UIColor.green
        let colorB = UIColor.blue
        let colorC = UIColor.red
        tweenView.backgroundColor = colorA

        controller.tween(from: colorA, at: 0.0)
            .to(colorB, at: 0.5)
            .then(to: colorC, at: 1.0)
            .with(action: tweenView.twc_applyBackgroundColor)
    }
}
