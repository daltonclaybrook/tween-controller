//
//  StartViewController.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/26/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

import UIKit
import TweenController

class StartViewController: UIViewController, TutorialViewController {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var buttonsContainerView: UIView!
    @IBOutlet var pageControl: UIPageControl!
 
    private var appearanceToken: dispatch_once_t = 0
    private var tweenController: TweenController!
    private var scrollView: UIScrollView!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        dispatch_once(&appearanceToken) {
            let (tc, scrollView) = TutorialBuilder.buildWithContainerViewController(self)
            self.tweenController = tc
            self.scrollView = scrollView
            scrollView.delegate = self
        }
    }
}

extension StartViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        tweenController.updateProgress(scrollView.contentOffset.x)
    }
}
