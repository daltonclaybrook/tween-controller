//
//  ViewController.swift
//  TweenControllerDemo
//
//  Created by Dalton Claybrook on 5/9/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

import UIKit
import TweenController

extension CALayer {
    func applyAffineTransform(transform: CGAffineTransform) {
        self.setAffineTransform(transform)
    }
}

extension UIView {
    func applyBackgroundColor(color: UIColor) {
        self.backgroundColor = color
    }
}

class ViewController: UIViewController {

    let controller = TweenController()
    @IBOutlet private var tweenView: UIView!
    private var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweenTransform()
        tweenColor()
        observeBoundaries()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.timerFired(_:)), userInfo: nil, repeats: true)
    }
    
    func timerFired(timer: NSTimer) {
        controller.updateProgress(controller.progress + 0.01)
    }
    
    //MARK: Private
    
    private func tweenTransform() {
        let transformA = CGAffineTransformIdentity
        let transformB = CGAffineTransformMakeScale(2.0, 2.0)
        let transformC = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        
        controller.tweenFrom(transformA, at: 0.0)
            .to(transformB, at: 0.5)
            .thenTo(transformC, at: 1.0)
            .withAction(tweenView.layer.applyAffineTransform)
    }
    
    private func tweenColor() {
        let colorA = UIColor.greenColor()
        let colorB = UIColor.blueColor()
        let colorC = UIColor.redColor()
        tweenView.backgroundColor = colorA
        
        controller.tweenFrom(colorA, at: 0.0)
            .to(colorB, at: 0.5)
            .thenTo(colorC, at: 1.0)
            .withAction(tweenView.applyBackgroundColor)
    }
    
    private func observeBoundaries() {
        controller.observeForwardBoundary(0.5) {
            print("halfway there!")
        }
        
        controller.observeForwardBoundary(1.0) { [weak self] in
            print("finished!")
            self?.timer.invalidate()
            self?.timer = nil
            
            self?.tweenView.backgroundColor = UIColor.redColor()
            self?.tweenView.layer.setAffineTransform(CGAffineTransformMakeRotation(CGFloat(M_PI_2)))
        }
    }
}

