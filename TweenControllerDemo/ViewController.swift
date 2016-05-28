//
//  ViewController.swift
//  TweenControllerDemo
//
//  Created by Dalton Claybrook on 5/9/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

import UIKit
import TweenController

class ViewController: UIViewController {
    
    let controller = TweenController()
    @IBOutlet private var tweenView: UIView!
    private var timer: NSTimer!
    private var timesFired: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweenTransform()
        tweenColor()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.timerFired(_:)), userInfo: nil, repeats: true)
    }
    
    func timerFired(timer: NSTimer) {
        timesFired += 1
        controller.updateProgress(Double(timesFired) * 0.01)
        if controller.progress >= 1.0 {
            self.timer.invalidate()
            self.timer = nil
        }
    }
    
    //MARK: Private
    
    private func tweenTransform() {
        let transformA = CGAffineTransformIdentity
        let transformB = CGAffineTransformMakeScale(2.0, 2.0)
        let transformC = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        
        controller.tweenFrom(transformA, at: 0.0)
            .to(transformB, at: 0.5)
            .thenTo(transformC, at: 1.0)
            .withAction(tweenView.layer.twc_applyAffineTransform)
    }
    
    private func tweenColor() {
        let colorA = UIColor.greenColor()
        let colorB = UIColor.blueColor()
        let colorC = UIColor.redColor()
        tweenView.backgroundColor = colorA
        
        controller.tweenFrom(colorA, at: 0.0)
            .to(colorB, at: 0.5)
            .thenTo(colorC, at: 1.0)
            .withAction(tweenView.twc_applyBackgroundColor)
    }
}
