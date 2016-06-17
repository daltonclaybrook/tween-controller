//
//  StartViewController.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/26/16.
//
//  Copyright (c) 2016 Dalton Claybrook
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

class StartViewController: UIViewController, TutorialViewController {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var buttonsContainerView: UIView!
    @IBOutlet var pageControl: UIPageControl!
 
    private var hasAppeared = false
    private var tweenController: TweenController!
    private var scrollView: UIScrollView!
    
    //MARK: Superclass
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !hasAppeared {
            hasAppeared = true
        
            let (tc, scrollView) = TutorialBuilder.buildWithContainerViewController(self)
            self.tweenController = tc
            self.scrollView = scrollView
            self.scrollView.delegate = self
        }
    }
    
    //MARK: Private
    
    private func updatePageControl() {
        pageControl.currentPage = Int(round(scrollView.contentOffset.x / containerView.frame.width))
    }
}

extension StartViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tweenController.update(progress: Double(scrollView.twc_horizontalPageProgress))
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updatePageControl()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            updatePageControl()
        }
    }
}
