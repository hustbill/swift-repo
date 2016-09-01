//
//  BLEReadWriteVC.swift
//  TableViewController
//
//  Created by bill on 9/1/16.
//  Copyright © 2016 bill. All rights reserved.
//


import UIKit
import CoreBluetooth


class BLEReadWriteVC : UIViewController, CBCentralManagerDelegate,  CBPeripheralDelegate{
    
    @IBOutlet weak var bleInfoLabel: UILabel!
    
    @IBOutlet weak var writeInfoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //start up a central manager object
        activeCentralManager = CBCentralManager(delegate: self, queue: nil)
    }
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func centralManagerDidUpdateState(central: CBCentralManager){
        print("CentralManager is initialized")
        
        switch (central.state){
        case .Unauthorized:
            print("The app is not authorized to use Bluetooth low energy.")
        case .PoweredOff:
            print("Bluetooth is currently powered off.")
        case .PoweredOn:
            print("Bluetooth is currently powered on and available to use.")
        case .Unsupported:
            print("Bluetooth is unsupported")
        case .Unknown:
            print("Bluetooth is unknow")
        default:break
        }
        
        if central.state == CBCentralManagerState.PoweredOn {
            // Scan for peripherals if BLE is turned on
            central.scanForPeripheralsWithServices(nil, options: nil)
            print("Searching for BLE Devices")
        }
        else {
            // Can have different conditions for all states if needed - print generic message for now
            print("Bluetooth switched off or not initialized")
        }
        
    }
    
}
