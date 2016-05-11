//
//  TweenController.swift
//  TweenController
//
//  Created by Dalton Claybrook on 5/9/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

public class TweenController {
    
    private(set) var progress: Double = 0.0
    
    //MARK: Public
    
    func describeTween<T:Tweenable>(fromValue fromValue: T, toValue: T, interval: ClosedInterval<Double>) -> TweenDescriptor<T> {
        let descriptor = TweenDescriptor(fromValue: fromValue, toValue: toValue, interval: interval, thenBlock: { [weak self] thenDescriptor in
            self?.registerDescriptor(thenDescriptor)
        })
        registerDescriptor(descriptor)
        return descriptor
    }
    
    func updateProgress(progress: Double) {
        let lastProgress = self.progress
        self.progress = progress
        
        
    }
    
    //MARK: Private
    
    private func registerDescriptor<T:Tweenable>(descriptor: TweenDescriptor<T>) {
        
    }
}
