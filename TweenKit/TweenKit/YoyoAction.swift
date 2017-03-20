//
//  YoyoAction.swift
//  TweenKit
//
//  Created by Steve Barnegren on 19/03/2017.
//  Copyright © 2017 Steve Barnegren. All rights reserved.
//

import Foundation

public class YoyoAction: FiniteTimeAction {
    
    // MARK: - Public
    
    public var onBecomeActive: () -> () = {}
    public var onBecomeInactive: () -> () = {}
    
    public var reverse = false

    public init(action: FiniteTimeAction) {
        
        self.action = action
        self.duration = action.duration * 2
    }
    
    // MARK: - Private Properties
    
    public internal(set) var duration: Double
    let action: FiniteTimeAction
    
    // MARK: - Private Methods
    
    public func willBecomeActive() {
        action.willBecomeActive()
    }

    public func didBecomeInactive() {
        action.didBecomeInactive()
    }
    
    public func update(t: CFTimeInterval) {
        
        if t < 0.5 {
            if action.reverse {
                action.reverse = false
            }
            let actionT = t * 2
            action.update(t: actionT)
        }
        else{
            if !action.reverse {
                action.reverse = true
            }
            let actionT = 1-((t - 0.5) * 2);
            action.update(t: actionT)
        }
    }
}

public extension FiniteTimeAction {
    
    public func yoyo() -> YoyoAction {
        return YoyoAction(action: self)
    }
}
