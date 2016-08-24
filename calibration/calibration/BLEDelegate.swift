//
//  BLEDelegate.swift
//  calibration
//
//  Created by bill on 8/19/16.
//  Copyright © 2016 bill. All rights reserved.
//

import CoreBluetooth

public protocol BLEDelegate {
    func centralManagerDidUpdateState(central: CBCentralManager)
}
