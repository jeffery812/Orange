//
//  Devices.swift
//  Orange
//
//  Created by Zhihui Tang on 2022-01-22.
//

import Foundation

struct Device: Decodable {
    let availabilityError: String?
    let dataPath: URL
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
        guard let files = try? FileManager.default.contentsOfDirectory(at: bundleContainerPath, includingPropertiesForKeys: [.isDirectoryKey], options: [.skipsHiddenFiles, .skipsPackageDescendants, .skipsSubdirectoryDescendants]) else {
            return nil
        }
        
        let userApplications = files.map {
            Application(device: self, rootPath: $0)
        }.compactMap { $0 }

        return userApplications
    }
    
    private var bundleContainerPath: URL {
        dataPath.appendingPathComponent("Containers/Bundle/Application")
    }

    private var dataContainerPath: URL {
        dataPath.appendingPathComponent("Containers/Data/Application")
    }
    
    private var identifierBundleMap: [String: String] {
        [:]
    }
    
    private func identifier(with url: URL) -> String? {
        if let contents = NSDictionary(contentsOf: url.appendingPathComponent(".com.apple.mobile_container_manager.metadata.plist")),
           let identifier = contents["MCMMetadataIdentifier"] as? String {
            return identifier
        }
        return nil
    }
    
    func boot() throws {
        shell("/usr/bin/xcrun", arguments: "simctl", "boot", self.udid)
        shell("/usr/bin/open", arguments: "-a", "simulator")
    }
    
    func shutdown() throws {
        shell("/usr/bin/xcrun", arguments: "simctl", "shutdown", self.udid)
    }
}
