//
//  Boundary.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/11/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

struct Boundary {    
    struct Direction: OptionSetType {
        let rawValue: Int
        init(rawValue: Int) { self.rawValue = rawValue }
        
        static let Forward = Direction(rawValue: 1 << 0)
        static let Backward = Direction(rawValue: 1 << 1)
        static let Both: Direction = [Forward, Backward]
    }
    
    let progress: Double
    let block: TweenObserverBlock
    let direction: Direction
}
