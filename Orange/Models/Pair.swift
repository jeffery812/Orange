//
//  Pair.swift
//  Orange
//
//  Created by Zhihui Tang on 2022-01-22.
//

import Foundation

struct Pair: Decodable {
    let watch: Pair.DeviceMeta
    let phone: Pair.DeviceMeta
    let state: String
    
    struct DeviceMeta: Decodable {
        let name: String
        let udid: String
        let state: String
    }
}
