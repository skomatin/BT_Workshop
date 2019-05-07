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

        
        //Fill in...
        
        
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {

        
        //Fill in...
        
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {

        
        //Fill in...
        
        

    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {

        
        //Fill in...
        
        
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        //Do nothing for now
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("Listing all available services")
        print(peripheral.services)
        if let services = peripheral.services {

            
            //Fill in...
            
            
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {

            
            //Fill in...
            
            
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {

        
        //Fill in...
        
        
        
    }
    
    private func notifyObservers(data: Data) {
        print("notifying observer")
    }
    
    func writeData(data: Data, characteristic: CBCharacteristic) {
        connectedPeripheral?.writeValue(data, for: characteristic, type: .withoutResponse)
    }
    
//Fill in...
    
    var connectedPeripheral: CBPeripheral!
    
    private var centralManager: CBCentralManager!
    private var peripheral: CBPeripheral!
    private var serviceDictionary: [CBService: [CBCharacteristic]]!
    
}
