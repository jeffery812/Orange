//
//  Runtime.swift
//  Orange
//
//  Created by Zhihui Tang on 2022-01-22.
//

import Foundation

struct Runtime: Decodable {
    let name: String
    let bundlePath: String
    let availabilityError: String?
    let buildversion: String
    let runtimeRoot: String
    let identifier: String
    let version: String
    let isAvailable: Bool
    let supportedDeviceTypes: [SupportedDeviceType]
}

struct SupportedDeviceType: Decodable {
    let bundlePath: String
    let name: String
    let identifier: String
    let productFamily: String
}
