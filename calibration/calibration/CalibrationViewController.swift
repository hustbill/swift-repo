//
//  CalibrationViewController.swift
//  calibration
//
//  Created by bill on 8/10/16.
//  Copyright © 2016 bill. All rights reserved.
//

import UIKit

class CalibrationViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var blueToothBondingInfo: UITextField!
    
    @IBOutlet weak var pairButton: UIButton!
 
    // MARK: Actions
    @IBAction func calibrationTest(sender: UIButton) {
        print("start to calibration")
    }
}
