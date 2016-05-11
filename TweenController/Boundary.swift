//
//  Boundary.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/11/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

struct Boundary {    
    enum Direction {
        case Forward, Backward
    }
    
    let progress: Double
    let block: () -> ()
    let direction: Direction
}
