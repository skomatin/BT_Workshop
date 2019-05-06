//
//  BT_iterface.swift
//  Bluetooth_Interface
//
//  Created by Saikiran Komatineni on 4/26/19.
//  Copyright © 2019 stella. All rights reserved.
//

import Foundation
import CoreBluetooth

class BT_Manager: NSObject, CBCentralManagerDelegate, CBPeripheralManagerDelegate, CBPeripheralDelegate {
    
    //Initializer for the BT_Manager class
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil) //initialize the Central Manager
        initVar()
    }
    
    // Initialize Variables
    func initVar() {
        peripheral = nil
        connectedPeripheral = nil
        self.serviceDictionary = [:]
    }
    
    //This is a required function of the CBCentralManager
    //Called when state of CBCentralanager is updated (when it is initialized)
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            print("Starting Scan")
            startScan()
        }
        else {
            print("Turn on Bluetooth on your phone")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        //        print(peripheral.name ?? "nil")
        if  "DSD TECH" == peripheral.name {
            if self.peripheral == nil {
                self.peripheral = peripheral
                self.centralManager.connect(peripheral, options: nil)
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        self.centralManager?.stopScan()
        if nil == self.connectedPeripheral {
            self.connectedPeripheral = peripheral
            self.connectedPeripheral.delegate = self        //Allowing the peripheral to discover services
            print("connected to: \(peripheral.name!)")
            self.connectedPeripheral.discoverServices(nil)      //look for services for the specified peripheral
        }
        
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("disconnected from \(self.peripheral.name!)")
        initVar() //initialize variables to allow for a new connection
        //Do Something
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        //Do nothing for now
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("Listing all available services")
        print(peripheral.services)
        if let services = peripheral.services {
            for service in services{
                self.connectedPeripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            self.serviceDictionary[service] = service.characteristics
            for characteristic in characteristics{
                self.connectedPeripheral.setNotifyValue(true, for: characteristic)
                
                let data = "a\n".data(using: .utf8)!
                writeData(data: data, characteristic: characteristic)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let data = characteristic.value {
            notifyObservers(data: data)
            let val = String.init(data: data, encoding: .utf8) ?? "nil"
            print("val = ", val)
        }
        //print(serviceDictionary)
    }
    
    private func notifyObservers(data: Data) {
        print("notifying observer")
    }
    
    func writeData(data: Data, characteristic: CBCharacteristic) {
        connectedPeripheral?.writeValue(data, for: characteristic, type: .withoutResponse)
    }
    
    private func startScan() {
        centralManager?.stopScan()
        centralManager?.scanForPeripherals(withServices: nil, options: nil)
    }
    
    var connectedPeripheral: CBPeripheral!
    
    private var centralManager: CBCentralManager!
    private var peripheral: CBPeripheral!
    private var serviceDictionary: [CBService: [CBCharacteristic]]!
    
}
