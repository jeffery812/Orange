//
//  SimCtrlResult.swift
//  Orange
//
//  Created by Zhihui Tang on 2022-01-22.
//

import Foundation

struct SimCtrlResult: Decodable {
    let devicetypes: [DeviceType]
    let runtimes: [Runtime]
    let devices: [String: [Device]]
    let pairs: [String: Pair]
}
//
//extension SimCtrlResult {
//    var applications: [Application] {
//        let aa = devices.compactMap {
//            print($0.value)
//            
//        }
//        for (version, deviceList) in devices {
//            for device in deviceList {
//                print("\(version), \(device.name)")
//                Application(device: device, rootPath: device.dataPath)
//            }
//        }
//       
//        let a = devices.map { (version, deviceList) in
//            Application(rootPath: "")
//        }
//        return []
//    }
//}


