//
//  BLEScanViewController.swift
//  calibration
//  Reference:
//  1. Core Bluetooth Programming Guide
//
//  Created by bill on 8/17/16.
//  Copyright © 2016 bill. All rights reserved.
//

import Foundation

import UIKit
import CoreBluetooth


let BLEP_SERVICE = "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
let nRF_TX = "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"
let nRF_RX = "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"

var activeCentralManager: CBCentralManager?
var peripheralDevice: CBPeripheral?
var devices: Dictionary<String, CBPeripheral> = [:]
var deviceName: String?
var deviceRSSI = [NSNumber]()
var devicesServices: CBService!
var writeCharacteristics: CBCharacteristic!
var readCharacteristics: CBCharacteristic!


class BLEScanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CBCentralManagerDelegate
{
    var centralManager: CBCentralManager?
    var peripherals: Array<CBPeripheral> = Array<CBPeripheral>()
    
    
    
    var tableView : UITableView?
    var items = ["wuhan", "shanghai", "beijing", "shenzhen"]


    @IBOutlet weak var ScannBLE: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("BLEScanViewController: Start up a central manager object")
        //activeCentralManager = CBCentralManager(delegate: self, queue: nil)
        centralManager = CBCentralManager(delegate: self, queue: dispatch_get_main_queue())
        initView()
        
    }
    
    func initView(){
        // init tableView data
        self.tableView=UITableView(frame:self.view.frame,style:UITableViewStyle.Plain)
        // setup tableView
        self.tableView!.dataSource=self
        // tableView delegate
        self.tableView!.delegate = self
        //
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView!)
        
        
    }
    
    
    
    // save the bluetooth device in a dictionary
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 1. Start up a CBCentralManager object
    // These objects are used to manage discovered or connected remote peripheral
    // device - NopainM3 (represented by CBPeripheral objects), includeing scanning for,
    // discovering, and connecting to advertising NopainM3
    func startCentralManager() {
        let myCentralManager  = CBCentralManager(delegate: self, queue: nil)
        
        // 2. Discover and connect to peripheral devices(NopainM3) that are advertising
        myCentralManager.scanForPeripheralsWithServices(nil , options: nil)
    }
    
    
    // Monitoring Changes to the Central Manager’s State
    func centralManagerDidUpdateState(central: CBCentralManager) {
        print("CentralManager is initialized")
        
        if (central.state == CBCentralManagerState.PoweredOn)
        {
            self.centralManager?.scanForPeripheralsWithServices(nil, options: nil)
        }
        else
        {
            // do something like alert the user that ble is not on
            print("do nothing")
        }
        
    }
    
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber)
    {
        print("didDiscoverPeripheral")
        peripherals.append(peripheral)
        print(peripherals)
        tableView!.reloadData()
    }
    
    
    // 2. Discover and connect to peripheral devices(NopainM3) that are advertising
    
    // 3. Explore the data one a peripheral devcce after we have connected to it
    
    // 4. Send read and write requests to a characteristic value of a peripheral's service
    
    // 5. Subscribe to a characteristic's value to be notified when it is updated
    
    
    
    //UITableView methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        // parepare data
        print("prepare data source for tableview")
        let cell:UITableViewCell = self.tableView!.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        let peripheral = peripherals[indexPath.row]
        cell.textLabel?.text = peripheral.name
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return peripherals.count
    }
    
    
}