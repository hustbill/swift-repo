//
//  Task.swift
//  TableViewController
//
//  Created by bill on 8/30/16.
//  Copyright © 2016 bill. All rights reserved.
//


import UIKit

class Task : NSObject, NSCoding{
    // MARK: Properties
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    var step:  String
    var state: String
    
    struct PropertyKey {
        static let stepKey = "step"
        static let stateKey = "state"
    }
    
    // MARK: Initialization
    
    init?(step: String, state: String) {
        // Initialize stored properties.
        self.step = step
        self.state = state
        
         super.init()
        
        // Initialization should fail if there is no state or if the step is negative.
        if state.isEmpty || step.isEmpty {
            return nil
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(step, forKey: PropertyKey.stepKey)
        aCoder.encodeObject(state, forKey: PropertyKey.stateKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let step = aDecoder.decodeObjectForKey(PropertyKey.stepKey) as! String
        let state = aDecoder.decodeObjectForKey(PropertyKey.stateKey) as! String

        
        self.init(step: String(UTF8String: step)!, state: String(state))
    }
}

