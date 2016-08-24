//
//  BLEFactory.swift
//  calibration
//
//  Created by bill on 8/19/16.
//  Copyright © 2016 bill. All rights reserved.
//

import Foundation
import CoreBluetooth


/**
 Factory responsible for all operations connected with Bluetooth connection
 - startScan()
 - centralManagerDidUpdateState(central: CBCentralManager)
 - discoverUnits(central: CBCentralManager
 - centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber)
 - centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral)
 - peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?)
 - peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?)
 - peripheral(peripheral: CBPeripheral, didWriteValueForCharacteristic characteristic: CBCharacteristic, error: NSError?)
 - stopScan()
 - connectToUnit(peripheral: CBPeripheral)
 - closeConnection(peripheral : CBPeripheral)
 */

public final class BLEFactory :NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    // Init part
   // public static var sharedInstance = BLEFactory()
    
    public var central : CBCentralManager!
    var peripheral = [CBPeripheral!]()
    //public var currentView : UIViewController!
    public var delegate : BLEDelegate?
    
    var unitData = [String: String]()
    
    let serviceId = CBUUID(string: BLEP_SERVICE)
    
    public let characteristicId = [    "ssid" :  CBUUID(string: "C83816F7-4430-43AF-B980-3A66FF08A9CE"),
                                       "security" :  CBUUID(string: "C6217DA6-99EF-40C6-90F9-47C21F8D48AB"),
                                       "password" :  CBUUID(string: "C9DAC10A-2597-4551-95BC-102AFA2CBBA9"),
                                       "mainFlowId" :  CBUUID(string: "C516089A-58C3-4D6E-9FBC-1B8C473C3C0E"),
                                       "liveFlowId" :  CBUUID(string: "CE5BD003-CC4F-4E27-8C4C-FA83A10F6866"),
                                       ]
    
    
    /*
     1. Start up a CBCentralManager object
         - Note: It triggers centralManagerDidUpdateState
     */
    public func startScan() {
        self.central = CBCentralManager(delegate: self, queue: nil)
        print("Scan Started")
    }
    
    /**
     Checks state of the central
     
     - Note: It triggers .centralManagerDidUpdate State on View Controller delegate.
     */
    public func centralManagerDidUpdateState(central: CBCentralManager) {
        self.delegate?.centralManagerDidUpdateState(central)
    }
    
    /*
      2. Scanning for peripherals(NopainM3) that advertise our service
     - Note: It triggers centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber).

     */
    public func discoverUnits(central: CBCentralManager) {
        //central.scanForPeripheralsWithServices([self.serviceId], options: nil)
        central.scanForPeripheralsWithServices(nil, options: nil)
        print("Scanning started")
    }
    
    /*
     It append found peripheral to list of peripherals
    
     - Note:  It triggers connection to peripheral.
     */
    public func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        print("Discovered \(peripheral.name)")
        print("identifier \(peripheral.identifier)")
        print("services \(peripheral.services)")
        print("RSSI \(RSSI)")
        
        self.peripheral.append(peripheral)
        connectToUnit(peripheral)
    }
    
    public func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print("Connected to \(peripheral)")
        peripheral.delegate = self;
        peripheral.discoverServices([serviceId])
    }
    
    // 3. Explore the data one a peripheral devcce after we have connected to it
    //public func peripheral(peripheral: CBPeripheral, did)
    public func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        var characteristicUUIDs: [CBUUID] = [CBUUID]()
        for (_, uuid) in characteristicId {
            characteristicUUIDs.append(uuid)
        }
        
        // Display prompt
//        let alertController = UIAlertController(title: "Enter Wifi Data",
//                                                message: nil, preferredStyle: .Alert)
//        alertController.addTextFieldWithConfigurationHandler {(textField) in
//            textField.placeholder = "SSID"
//        }
//        alertController.addTextFieldWithConfigurationHandler { (textField) in
//            textField.placeholder = "Password"
//            textField.secureTextEntry = true
//        }
//        let OKAction = UIAlertAction(title: "Sure, continue", style: .Default) { (action) in
//            ///After prompt is subbmited it sends data to perihperal
//            self.unitData = [
//                "ssid" : "Wifi Mreza",
//                "security" : "WPA2",
//                "password":"SomeTopSeceretThing"
//            ]
//            peripheral.discoverCharacteristics(characteristicUUIDs, forService: (peripheral.services?.first)!)
//            
//        }
//        alertController.addAction(OKAction)
        
       // currentView.presentViewController(alertController, animated: true) {
//        }
    }

    // 4. Send read and write requests to a characteristic value of a peripheral's service
    
    // 5. Subscribe to a characteristic's value to be notified when it is updated
    
    /**
     It builds data package of updated peripheral characteristics and attempts to write it on peripheral
     
     */
   /* public func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        FTFactory.sharedInstance.setupUnit() { recordId in
            self.unitData["mainFlowId"] = recordId!.flowId
            self.unitData["liveFlowId"] = recordId!.liveDataFlowId
            
            for characteristic in service.characteristics! {
                var data : String?
                
                switch(characteristic.UUID) {
                case self.characteristicId["ssid"]!:
                    data = self.unitData["ssid"]
                    
                case self.characteristicId["security"]!:
                    data = self.unitData["security"]
                    
                case self.characteristicId["password"]!:
                    data = self.unitData["password"]
                    
                case self.characteristicId["mainFlowId"]!:
                    data = self.unitData["mainFlowId"]
                    
                case self.characteristicId["liveFlowId"]!:
                    data = self.unitData["liveFlowId"]!
                    
                default:
                    break
                }
                
                if (data != nil) {
                    peripheral.writeValue(data!.dataUsingEncoding(NSUTF8StringEncoding)!, forCharacteristic: characteristic, type: .WithResponse)
                }
            }
        }
    }*/
    
    // When the data is writtern it closes connection
    public func peripheral(peripheral: CBPeripheral, didWriteValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        if (error != nil) {
            print("Error writing characteristic: \(characteristic.UUID)")
            print(error)
        }
        closeConnection(peripheral)
    }
    
    // This function stops peripheral scanning
    public func stopScan() {
        self.central.stopScan()
        print("Scan stopped")
    }
    
    /// This function connects to pheripheral
    public func connectToUnit(peripheral: CBPeripheral) {
        self.central.connectPeripheral(peripheral, options: nil)
        print("Trying to connect to Unit")
    }
    
    var connection = 0
    /// This function closes connections to peripheral after it has received all 4 characteristics
    public func closeConnection(peripheral : CBPeripheral) {
        connection += 1
        if (connection == 4) {
            self.central.cancelPeripheralConnection(peripheral)
            print("Disconnected from peripheral")
        }
    }
}

