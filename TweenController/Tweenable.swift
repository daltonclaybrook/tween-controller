//
//  Tweenable.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/9/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

public protocol Tweenable {
    static func valueBetween(val1: Self, _ val2: Self, percent: Double) -> Self
}
