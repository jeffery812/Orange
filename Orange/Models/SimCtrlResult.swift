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
