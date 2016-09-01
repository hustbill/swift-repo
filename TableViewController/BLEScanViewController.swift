//
//  BLEScanViewController.swift
//  TableViewController
//
//  Created by bill on 9/1/16.
//  Copyright © 2016 bill. All rights reserved.
//

import UIKit
import CoreBluetooth

class BLEScanViewController: UIViewController, CBPeripheralDelegate, CBCentralManagerDelegate {
    @IBOutlet weak var Labelvalue: UILabel!
    
    
    override func viewDidLoad() {0
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        if let activeCentralManager = activeCentralManager{
            activeCentralManager.delegate = self
        }
        if let peripheralDevice = peripheralDevice{
            peripheralDevice.delegate = self
        }
        if(check){
            print("this is the one \(activeCentralManager)")
            print("this is the device\(peripheralDevice)")
            NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(BLEScanViewController.requireData), userInfo: nil,repeats: true)
            
        }
        
    }
    
    func centralManagerDidUpdateState(central: CBCentralManager) {
        if central.state == CBCentralManagerState.PoweredOn {
            print("Bluetooth ON")
        }
        else {
            // Can have different conditions for all states if needed - print generic message for now
            print("Bluetooth switched off or not initialized")
        }
        
    }
    
    func requireData(){
        //write CMD
        //peripheralDevice!.writeValue(NSData(bytes: &alertLevel, length: 3), forCharacteristic: writeCharacteristics, type: CBCharacteristicWriteType.WithoutResponse)
        print("Send Request for glucose reading")   // var reqGlucose = 0x50
        // print(NSData(bytes: &reqGlucose, length: 2)) // update by bzhang 08/12/16
        let data = NSData(bytes: [0x02,0x50] as [UInt8], length: 2)
        print(data)
        peripheralDevice!.writeValue(data, forCharacteristic: writeCharacteristics, type: CBCharacteristicWriteType.WithoutResponse)
    }
    
    
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        if(error != nil){
            print("Error Reading \(characteristic.UUID) characteristic value: \(error!.localizedDescription)")
        }else{
            let data = characteristic.value
            print("Update value is \(data),length:\(data!.length), sizeof\(sizeof(UInt8))")
            let count = data!.length / sizeof(UInt8)
            
            // create an array of Uint8
            var array = [UInt8](count: count, repeatedValue: 0)
            
            // copy bytes into array
            data!.getBytes(&array, length:6)
            //var value = (Float(array[5])+Float(array[4])*15+Float(array[3])*15*15)/180
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

