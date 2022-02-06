//
//  SimCtrlResult.swift
//  Orange
//
//  Created by Zhihui Tang on 2022-01-22.
//

import Foundation

struct SimCtrlResult: Decodable {
    let deviceTypes: [DeviceType]
    var runtimes: [Runtime]
    let devices: [String: [Device]]
    let pairs: [String: Pair]
    
    private enum CodingKeys: String, CodingKey {
        case deviceTypes = "devicetypes"
        case runtimes
        case devices
        case pairs
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        deviceTypes = try container.decode([DeviceType].self, forKey: .deviceTypes)
        runtimes = try container.decode([Runtime].self, forKey: .runtimes)
        devices = try container.decode([String: [Device]].self, forKey: .devices)
        pairs = try container.decode([String: Pair].self, forKey: .pairs)
        
        for i in 0..<runtimes.count {
            runtimes[i].update(devices: devices[runtimes[i].identifier] ?? [])
        }
    }
}

