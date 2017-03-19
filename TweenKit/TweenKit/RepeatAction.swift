//
//  RepeatAction.swift
//  TweenKit
//
//  Created by Steve Barnegren on 19/03/2017.
//  Copyright © 2017 Steve Barnegren. All rights reserved.
//

import Foundation

public class RepeatAction: SchedulableAction {
    
    // MARK: - Public
    
    public init(action: SchedulableAction, times: Int) {
        self.action = action
        self.repeats = times
        self.duration = action.duration * Double(times)
    }
    
    // MARK: - Private Properties
    public var reverse: Bool = false {
        didSet{
            action.reverse = reverse
        }
    }

    public internal(set) var duration: CFTimeInterval
    let action: SchedulableAction
    let repeats: Int
    
    // MARK: - Private Methods
    
    public func updateWithTime(t: CFTimeInterval) {
        
        let actionT = ( t * Double(repeats) ).fract
        action.updateWithTime(t: actionT)
    }
    
}

public extension SchedulableAction {
    
    public func repeated(_ times: Int) -> RepeatAction {
        return RepeatAction(action: self, times: times)
    }
}
