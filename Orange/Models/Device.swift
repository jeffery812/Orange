//
//  Devices.swift
//  Orange
//
//  Created by Zhihui Tang on 2022-01-22.
//

import Foundation

struct Device: Decodable {
    let availabilityError: String?
    let dataPath: String
    let logPath: String
    let udid: String
    let isAvailable: Bool
    let deviceTypeIdentifier: String
    let state: State
    let name: String
    
    enum State: String, Decodable {
        case shutdown = "Shutdown"
        case booted = "Booted"
        case unavailable = "(unavailable)"
        case disconnected = "(active, disconnected)"
    }
}

extension Device {
    var applications: [Application]? {
        guard let files = try? FileManager.default.contentsOfDirectory(atPath: applicationPath) else {
            return nil
        }
        let userApplications = files.map {
            Application(device: self, rootPath: "\(applicationPath)\($0)")
        }.compactMap { $0 }

        return userApplications
    }
    
    private var applicationPath: String {
        dataPath + "/Containers/Bundle/Application/"
    }
    
    func boot() throws {
        shell("/usr/bin/xcrun", arguments: "simctl", "boot", self.udid)
        shell("/usr/bin/open", arguments: "-a", "simulator")
    }
    
    func shutdown() throws {
        shell("/usr/bin/xcrun", arguments: "simctl", "shutdown", self.udid)
    }
}
