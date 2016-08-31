//
//  Task.swift
//  TableViewController
//
//  Created by bill on 8/30/16.
//  Copyright © 2016 bill. All rights reserved.
//


import UIKit

class Task {
    // MARK: Properties
    
    var step:  Int
    var state: String
    
    // MARK: Initialization
    
    init?(step: Int, state: String) {
        // Initialize stored properties.
        self.step = step
        self.state = state
        
        // Initialization should fail if there is no state or if the step is negative.
        if state.isEmpty || step < 0 {
            return nil
        }
    }
}

