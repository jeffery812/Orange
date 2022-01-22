//
//  File.swift
//  Orange
//
//  Created by Zhihui Tang on 2022-01-22.
//

import Foundation

struct DeviceType: Decodable {
    let name: String
    let identifier: String
    let minRuntimeVersion: Int
    let bundlePath: String
    let maxRuntimeVersion: Int
    let productFamily: String
}
