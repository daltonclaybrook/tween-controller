//
//  KeypathListener.swift
//  TweenController
//
//  Created by Dalton Claybrook on 1/9/17.
//  Copyright © 2017 Claybrook Software. All rights reserved.
//

import Foundation
import TweenController

class KeypathListener<T: Tweenable>: NSObject {
    
    let keyPath = "com.claybrooksoftware.tweencontroller.keyPath"
    private(set) var values = [T]()
    
    override func setValue(_ value: Any?, forKeyPath keyPath: String) {
        guard keyPath == self.keyPath, let tweenable = value as? T else {
            super.setValue(value, forKeyPath: keyPath)
            return
        }
        values.append(tweenable)
    }
}
