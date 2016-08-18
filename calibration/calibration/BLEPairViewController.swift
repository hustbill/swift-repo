//
//  BLEPairViewController.swift
//  calibration
//
//  Created by bill on 8/17/16.
//  Copyright © 2016 bill. All rights reserved.
//

import UIKit

class BLEPairViewController: UIViewController {

    // MARK: Properties

    @IBOutlet weak var BLEDeviceList: UITableView!
    
    // MARK: Actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("print the bluetooth list")
    }
    
}