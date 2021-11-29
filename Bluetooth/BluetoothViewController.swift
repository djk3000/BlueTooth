import Foundation
import UIKit
import CoreBluetooth
import SwiftUI

class BluetoothViewController: UIViewController,CBCentralManagerDelegate,CBPeripheralDelegate {
    @State var model = Model.model
    
    var deviceDict = [String: Int]()
    //中心设备
    lazy var magager: CBCentralManager = CBCentralManager()
    //外设列表
    var connectPeripheral : CBPeripheral?
    
    var selfCentral: CBCentralManager?
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        self.selfCentral = central
        
        if (central.state == .poweredOn){
            print("打开蓝牙了")
            //必须状态ok后才可以扫描 要不不执行代理方法
            magager.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    
    func refresh() {
        if (selfCentral?.state == .poweredOn){
            magager.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    
    func timerRefresh() {
        Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { timer in
            self.deviceDict.removeAll()
            self.magager.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    
    //扫码到设备后回调方法
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber)
    {
        if peripheral.name != nil{
            if peripheral.name!.contains("RDLX6") {
                
                print("发现外设")
                print("名字 \(peripheral.name)")
                print("Rssi: \(RSSI)")
                print("外设UUID-->",peripheral.identifier.uuidString,"service-->",peripheral.services)
                print("advertisementData-->",advertisementData["kCBAdvDataLocalName"])
                
                guard RSSI.intValue<0 else{
                    return
                }
                if advertisementData["kCBAdvDataLocalName"] != nil {
                    deviceDict[advertisementData["kCBAdvDataLocalName"] as! String] = RSSI.intValue
                }
                //deviceDict[peripheral.name!] = RSSI.intValue
                let values = deviceDict.sorted(by: {$0.1 > $1.1})
                print(values.first?.key)
                print(values)
                
                print("======================================")
                model.name = values.first?.key
                model.rssi = values.first?.value
               
                
                //                print("peripheral.name = \(peripheral.name!)")
                //                print("central = \(central)")
                //                print("peripheral = \(peripheral)")
                //                print("RSSI = \(RSSI)")
                //                print("advertisementData = \(advertisementData)")
                //                if  (peripheral.name?.contains("RDLX6"))! != false
                //                {
                //                    self.magager.stopScan()
                //                    connectPeripheral = peripheral
                //                    self.magager.connect(peripheral, options: nil)
                //                }
            }
        }
    }
    
    //外设链接成功
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        self.magager.stopScan()
        connectPeripheral?.delegate = self
        print("连接成功")
    }
    
    //发现服务
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        print("发现服务UUID-->",peripheral.identifier.uuidString)
        
        //连接服务
        for service in peripheral.services! {
            connectPeripheral?.discoverCharacteristics(nil, for: service)
        }
    }
    
    //发现特征
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        //弹框
        
        for characteristic in service.characteristics! {
            print("发现特征UUID---> ",String(describing:characteristic.uuid))
            
        }
    }
    
    /** 断开连接 */
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("断开连接")
        // 重新连接
        central.connect(peripheral, options: nil)
    }
    
    //连接外设失败
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("连接外设失败")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerRefresh()
        magager.delegate = self
    }
}
