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

class BLESearchVC : UIViewController, CBCentralManagerDelegate,  CBPeripheralDelegate{
    

    @IBOutlet weak var deviceLabel: UILabel!
    
    @IBOutlet weak var commandTextField: UITextField!
  
    @IBOutlet weak var glucoseTextField: UITextField!
    
    @IBOutlet weak var connect2M3Btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //start up a central manager object
        activeCentralManager = CBCentralManager(delegate: self, queue: nil)
        
        srand48(Int(time(nil)))
        let randomCalibrationVal = String(format:"%.1f", drand48() * 12)
        print("\(randomCalibrationVal)")

        glucoseTextField.text = randomCalibrationVal
        let randomNumber = arc4random_uniform(10)
        commandTextField.text = (String)(0xC0 + randomNumber)
        print(commandTextField.text)

    }
    
    override func viewDidAppear(animated: Bool) {
        // Clear devices dictionary.
        devices.removeAll(keepCapacity: false)
        devicesRSSI.removeAll(keepCapacity: false)
        // Initialize central manager on load
        activeCentralManager = CBCentralManager(delegate: self, queue: nil)
     
      
    }    
    func update(){
        // Clear devices dictionary.
        devices.removeAll(keepCapacity: false)
        devicesRSSI.removeAll(keepCapacity: false)
        check = false
        // Initialize central manager on load
        activeCentralManager = CBCentralManager(delegate: self, queue: nil)
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
                print("CenCentalManagerDelegate didDiscoverPeripheral")
                print("Discovered \(name)")
                print("Peripheral: \(devices[name])")
                print("Rssi: \(devicesRSSI[devicesRSSI.count-1].stringValue)")
            }
        }
        
    }
    
    @IBAction func connect2Device(sender: AnyObject) {
        print("connect2Device")
        connectDevice()
    }
    
    //click to choose
     func connectDevice()  {
        if (devices.count > 0) {
            let discoveredPeripheralArray = Array(devices.values)
            peripheralDevice = discoveredPeripheralArray[0]
            
            peripheralDevice!.delegate = self
            deviceName = peripheralDevice!.name
            // Stop looking for more peripherals.
            activeCentralManager!.stopScan()
            print("Stop scan the Ble Devices")
            // Connect to this peripheral.
            activeCentralManager!.connectPeripheral(peripheralDevice!, options: nil)
            print("Connecting \(deviceName)")
            if let name = deviceName{
               deviceLabel.text = name
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
    
    @IBAction func write2Device(sender: AnyObject) {
        print("write to M3")
      
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
                // peripheral.readValueForCharacteristic(readCharacteristics)
            }
            
            if(thisCharacteristic.UUID == CBUUID(string: nRF_TX)){
                _ = (thisCharacteristic as CBCharacteristic)
                writeCharacteristics = thisCharacteristic
                print("did discover charateristic,  peripheral.writeValue ")
                //let fileName = "PLS.AMO"
                let glucoseval : String =  glucoseTextField.text!
                let optCode = (UInt8)(commandTextField.text!)
                let data = prepareGlucoseData(optCode!, glucoseval: glucoseval)
                //let data = prepareAMOData(fileName)
                print("\(data)")
                peripheral.writeValue(data, forCharacteristic: writeCharacteristics as CBCharacteristic,
                                      type: CBCharacteristicWriteType.WithoutResponse)
                
            }
        }
    }

    
    //check write
    func peripheral(peripheral: CBPeripheral!, didWriteValueForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
        if(error != nil){
            //print("Error writing characteristic value: \(error.localizedDescription)")
        //    print("Error writing characteristic value: \(error.localizedDescription)")
           print("Write failed...error: \(error)")
//            return
            
        }else{
            print("Write value success!")
        }
    }
    
   
    
    // 6.1 callback function for reading the value of Characteristic
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        if(error != nil){
            print("Error Reading characteristic value: \(error)")
        }else{
            // var count:UInt = 0
            let data = characteristic.value
            print("M3 response : Update value is \(data)")
         
            let count = data!.length / sizeof(UInt8)
            
            // create an array of Uint8
            var array = [UInt8](count: count, repeatedValue: 0)
            
            // copy bytes into array
            data!.getBytes(&array, length:count * sizeof(UInt8))
            
            print(array) // [3, 0, 6]

            
//            if (array[2] == 6) {  // 0x30006   ACK from M3
//                let glucoseval : String = glucoseTextField.text!
//                let optCode = (UInt8)(commandTextField.text!)
//                let glucoseData =  prepareGlucoseData(optCode!, glucoseval: glucoseval)
//                print("Send glucose data to M3 : \(glucoseData)")
//                peripheral.writeValue(glucoseData, forCharacteristic: writeCharacteristics as CBCharacteristic,
//                                      type: CBCharacteristicWriteType.WithoutResponse)
//            }
//            
//            characteristic.value!.getBytes(&count, length:sizeof(UInt32))
//            let str = NSString(format: "%llu", count) as String
//            print(str)
        }
    }
    
    
    // data : 0x10 0xC0 10.8
    // optCode : 0xC0, 0XC1, 0xC2 ...
    func prepareGlucoseData(optCode : UInt8, glucoseval : String) -> NSData {
        var txBuffer:[UInt8] = [0x06, optCode]
        let buf = [UInt8](glucoseval.utf8)     // send glucose name
        
        txBuffer += buf
        print(txBuffer)
        let data = NSData(bytes: txBuffer, length: txBuffer.count)
        
        return data
    }
    
    // data : 0x10 0x70 C A L 1 . T X T
    func prepareCalibratinData(fileName : String) -> NSData {
        var txBuffer:[UInt8] = [0x10, 0x70]
        let buf = [UInt8](fileName.utf8)     // send file name
        txBuffer += buf
        let data = NSData(bytes: txBuffer, length: txBuffer.count)
        
        return data
    }
    
    // data : 0x09 0x70 PLS.AMO
    func prepareAMOData(fileName : String) -> NSData {
        var txBuffer:[UInt8] = [0x09, 0x70]
        let buf = [UInt8](fileName.utf8)     // send file name
        txBuffer += buf
        let data = NSData(bytes: txBuffer, length: txBuffer.count)
        return data
    }
    
   
//    func sendBloodGlucoseVal(glucoseval : String) {
//        let data = prepareGlucoseData(glucoseval)
//        print(data)
//        
////        peripheral.writeValue(data, forCharacteristic: writeCharacteristics as CBCharacteristic,
////                              type: CBCharacteristicWriteType.WithoutResponse)
//        
//    }
    
   
    
    
    //check subscribe
    func peripheral(peripheral: CBPeripheral, didSubscribeToCharacteristic charceteristic: CBCharacteristic, error: NSError?){
        print("subscribe \(charceteristic.UUID)")
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

