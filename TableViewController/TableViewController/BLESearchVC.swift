//
//  BLESearchVC.swift
//  TableViewController
//
//  Created by bill on 9/1/16.
//  Copyright © 2016 bill. All rights reserved.
//
/*
 Bluetooth：  Garmin
 Label name is vívofit
 Stop scan the Ble Devices
 Connected to a peripheral
 CBPeripheralDelegate didDiscoverServices
 9B012401-BC30-CE9A-E111-0F67E491ABDE
 Discover service, vívofit  <CBService: 0x147d2e740, isPrimary = YES, UUID = 9B012401-BC30-CE9A-E111-0F67E491ABDE>
 */

import UIKit
import CoreBluetooth


var activeCentralManager: CBCentralManager?
var peripheralDevice: CBPeripheral?
var devices: Dictionary<String, CBPeripheral> = [:]
var deviceName: String?
var devicesRSSI = [NSNumber]()
var devicesServices: CBService!
var writeCharacteristics: CBCharacteristic!
var readCharacteristics: CBCharacteristic!
let BLEP_SERVICE = "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
let nRF_TX = "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"
let nRF_RX = "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"
var alertLevel = 0x02

var reqGlucose = 0x0250  // 02 -length,  50 - Request for glucose reading
var check:Bool = false

class BLESearchVC : UITableViewController, CBCentralManagerDelegate,  CBPeripheralDelegate{
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //start up a central manager object
        activeCentralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        // Clear devices dictionary.
        devices.removeAll(keepCapacity: false)
        devicesRSSI.removeAll(keepCapacity: false)
        // Initialize central manager on load
        activeCentralManager = CBCentralManager(delegate: self, queue: nil)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(BLESearchVC.update), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
    }
    
    func update(){
        // Clear devices dictionary.
        devices.removeAll(keepCapacity: false)
        devicesRSSI.removeAll(keepCapacity: false)
        check = false
        // Initialize central manager on load
        activeCentralManager = CBCentralManager(delegate: self, queue: nil)
        self.refreshControl?.endRefreshing()
    }
    
    //check the state of bluetooth，
    // 2、Discovering Peripheral Devices That Are Advertising
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
    
    //save the bluetooth device in a dictionary
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        peripheralDevice = peripheral
        if let name = peripheral.name{
            if devices[name] == nil{
                devices[name] = peripheral
                devicesRSSI.append(RSSI)
                peripheral.delegate = self
                self.tableView.reloadData()
                print("CenCentalManagerDelegate didDiscoverPeripheral")
                print("Discovered \(name)")
                print("Peripheral: \(devices[name])")
                print("Rssi: \(devicesRSSI[devicesRSSI.count-1].stringValue)")
            }
        }
        
    }
    
    //Did connect Peripheral
    // 连接的结果会调用下面三个回调函数
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print("Connected to a peripheral")
        peripheral.delegate = self
        
        // 4、Discovering the Services of a Peripheral That You’re Connected To
        peripheral.discoverServices(nil)
        check = true
    }
    
    /*func  didConnected() ->Bool{
     if(check == true) {return true}
     else {return false}
     
     }*/
    
    
    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("CenCentalManagerDelegate didFailToConnectPeripheral")
    }
    
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("CenCentalManagerDelegate didDisconnectPeripheral")
    }
    

    
    //did discover services
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        print("CBPeripheralDelegate didDiscoverServices")
        for  service in peripheral.services! {
            print("\(service.UUID)")
            if(service.UUID == CBUUID(string: BLEP_SERVICE)){
                print("Discover service \(service)")
                print("UUID \(service.UUID)")
                let BlepService = (service as CBService)
                // 5、Discovering the Characteristics of a Service
                peripheral.discoverCharacteristics(nil , forService: BlepService)
                
            } else {
                print("Discover service, vívofit  \(service)")
                print("UUID \(service.UUID)")
                let BlepService = (service as CBService)
                // 5、Discovering the Characteristics of a Service
                 peripheral.discoverCharacteristics(nil , forService: BlepService)
            }
            
        }
    }
    //did discover charateristic
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        for charateristic in service.characteristics!{
            
            let thisCharacteristic = charateristic
            // Set notify for characteristics here.
            if(thisCharacteristic.UUID == CBUUID(string: nRF_RX)){
                peripheral.setNotifyValue(true, forCharacteristic: thisCharacteristic)
                readCharacteristics = thisCharacteristic
                // 6、Retrieving the Value of a Characteristic
                print(" 6、Retrieving the Value of a Characteristic")
                peripheral.readValueForCharacteristic(readCharacteristics)
            }else if(thisCharacteristic.UUID == CBUUID(string: nRF_TX)){
                let nRFtxCharactic = (thisCharacteristic as CBCharacteristic)
                writeCharacteristics = thisCharacteristic
                //= (thisCharacteristic as CBCharacteristic)
                //peripheral.writeValue(NSData(bytes: &alertLevel, length: 1), forCharacteristic: writeCharacteristics as CBCharacteristic, type: CBCharacteristicWriteType.WithoutResponse)
                // updated by bzhang 08/12/16
                print("did discover charateristic,  peripheral.writeValue ")
                let data = NSData(bytes: [0x02,0x50] as [UInt8], length: 2)
                print(data)
                peripheral.writeValue(data, forCharacteristic: writeCharacteristics as CBCharacteristic,
                                      type: CBCharacteristicWriteType.WithoutResponse)
            } else {
//                 var alertLevel:UInt8 = 0x02
//                print("linkLossAlertService Discover characteristic \(charateristic)")
//                writeCharacteristics = (charateristic as CBCharacteristic)
//                //linkLossAlertCharacteristic 写入没有问题，所以通过这个写入来进行绑定
//                peripheral.writeValue(NSData(bytes: &alertLevel, length: 1), forCharacteristic: writeCharacteristics , type: CBCharacteristicWriteType.WithoutResponse)
                peripheral.setNotifyValue(true, forCharacteristic: thisCharacteristic)
                readCharacteristics = thisCharacteristic
                // 6、Retrieving the Value of a Characteristic
                print(" 6、Retrieving the Value of a Characteristic from vívofit ")
                peripheral.readValueForCharacteristic(readCharacteristics)
                
                
            }
            
        }
    }
    
    // 6.1 callback function for reading the value of Characteristic
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
        if(error != nil){
            print("Error Reading characteristic value: \(error.localizedDescription)")
        }else{
            var data = characteristic.value
            print("Update value is \(data)")
        }
        
    }
    
    
    //check subscribe
    func peripheral(peripheral: CBPeripheral, didSubscribeToCharacteristic charceteristic: CBCharacteristic, error: NSError?){
        print("subscribe \(charceteristic.UUID)")
    }
    
    // 
    
    
    //check write
    func peripheral(peripheral: CBPeripheral,
                    didWriteValueForCharacteristic characteristic: CBCharacteristic,
                                                   error: NSError?)
    {
        if (error != nil) {
            print("Write failed...error: \(error)")
            return
        }
        
        print("Write successul！")
    }
    
    
    
    //table view
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
        
    }
    //cell for row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("cell shows")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cellOfdeviceTableViewCell", forIndexPath: indexPath) as! cellOfdeviceTableViewCell
        
        var discoveredPeripheralArray = Array(devices.values)
        if let name = discoveredPeripheralArray[indexPath.row].name{
            if let textLabelText = cell.textTitle{
                textLabelText.text = name
                print("Label name is \(name)")
            }
            
            
        }
        return cell
    }
    
    //click to choose
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (devices.count > 0) {
            let discoveredPeripheralArray = Array(devices.values)
            peripheralDevice = discoveredPeripheralArray[indexPath.row]
            
            peripheralDevice!.delegate = self
            deviceName = peripheralDevice!.name
            // Stop looking for more peripherals.
            activeCentralManager!.stopScan()
            print("Stop scan the Ble Devices")
            // Connect to this peripheral.
            activeCentralManager!.connectPeripheral(peripheralDevice!, options: nil)
            if let _ = navigationController{
                navigationItem.title = "Connecting \(deviceName)"
            }
            
        }
        /*if let cell = tableView.cellForRowAtIndexPath(indexPath) {
         if cell.accessoryType == .None {
         cell.accessoryType = .Checkmark } else {
         cell.accessoryType = .None }
         }
         tableView.deselectRowAtIndexPath(indexPath, animated: true)*/
    }
    
    
    
    //test notif
    func peripheral(peripheral: CBPeripheral,
                    didUpdateNotificationStateForCharacteristic characteristic: CBCharacteristic,
                                                                error: NSError?)
    {
        if error != nil {
            
            print("Notify ..error: \(error)")
            print("the error ID is \(characteristic)")
        }
        else {
            print("Notify good！ isNotifying: \(characteristic.isNotifying)")
            print("the good ID is \(characteristic)")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

/*
 Notify good！ isNotifying: true
 the good ID is <CBCharacteristic: 0x137678860, UUID = 4ACBCD28-7425-868E-F447-915C8F00D0CB, properties = 0x12, value = (null), notifying = YES>
 Update value is Optional(<00000000 00000000 00000000 00000000 00000000>)
 Update value is Optional(<00022504 a0137209 2d0790b0 05e8e001 14010876>)
 Update value is Optional(<c3ad766f 66697408 76c3ad76 6f666974 03b58100>)
 Update value is Optional(<00022504 a0137209 2d0790b0 05e8e001 14010876>)
 Update value is Optional(<c3ad766f 66697408 76c3ad76 6f666974 03b58100>)
 Update value is Optional(<00022504 a0137209 2d0790b0 05e8e001 14010876>)
 Update value is Optional(<c3ad766f 66697408 76c3ad76 6f666974 03b58100>)
 Update value is Optional(<00022504 a0137209 2d0790b0 05e8e001 14010876>)
 Update value is Optional(<c3ad766f 66697408 76c3ad76 6f666974 03b58100>)
 Update value is Optional(<00022504 a0137209 2d0790b0 05e8e001 14010876>)
 Update value is Optional(<c3ad766f 66697408 76c3ad76 6f666974 03b58100>)
 Update value is Optional(<00022504 a0137209 2d0790b0 05e8e001 14010876>)
 Update value is Optional(<c3ad766f 66697408 76c3ad76 6f666974 03b58100>)
 Update value is Optional(<00022504 a0137209 2d0790b0 05e8e001 14010876>)
 Update value is Optional(<c3ad766f 66697408 76c3ad76 6f666974 03b58100>)
 Update value is Optional(<00022504 a0137209 2d0790b0 05e8e001 14010876>)
 Update value is Optional(<c3ad766f 66697408 76c3ad76 6f666974 03b58100>)
 Update value is Optional(<00022504 a0137209 2d0790b0 05e8e001 14010876>)
 Update value is Optional(<c3ad766f 66697408 76c3ad76 6f666974 03b58100>)
 Update value is Optional(<00022504 a0137209 2d0790b0 05e8e001 14010876>)
 Update value is Optional(<c3ad766f 66697408 76c3ad76 6f666974 03b58100>)
 
 */

