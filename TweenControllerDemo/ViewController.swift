//
//  ViewController.swift
//  TweenControllerDemo
//
//  Created by Dalton Claybrook on 5/9/16.
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

import UIKit
import TweenController

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
    
    //MARK: Private
    
    @objc
    private func timerFired(_ timer: Timer) {
        timesFired += 1
        controller.update(progress: Double(timesFired) * 0.0025)
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
