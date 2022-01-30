//
//  Devices.swift
//  Orange
//
//  Created by Zhihui Tang on 2022-01-22.
//

import Foundation
import Combine

struct Device: Decodable {
    let availabilityError: String?
    let dataPath: URL
    let logPath: URL
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
        guard let bundles = try? FileManager.default.contentsOfDirectory(
            at: dataPath.appendingPathComponent("Containers/Bundle/Application"),
            includingPropertiesForKeys: [.isDirectoryKey],
            options: [.skipsHiddenFiles, .skipsPackageDescendants, .skipsSubdirectoryDescendants])
        else {
            return nil
        }
        
        guard let datas = try? FileManager.default.contentsOfDirectory(
            at: dataPath.appendingPathComponent("Containers/Data/Application"),
            includingPropertiesForKeys: [.isDirectoryKey],
            options: [.skipsHiddenFiles, .skipsPackageDescendants, .skipsSubdirectoryDescendants])
        else {
            return nil
        }
        
        let identifierBundleMapping = bundles.reduce([String: URL]()) { dict, url in
            var new = dict
            new[identifier(of: url)] = url
            return new
        }
        let identifierDataMapping = datas.reduce([String: URL]()) { dict, url in
            var new = dict
            new[identifier(of: url)] = url
            return new
        }
        
        let applications = identifierBundleMapping
            .map { identifier, url in (url, identifierDataMapping[identifier]) }
            .map { Application(device: self, bundleContainer: $0, dataContainer: $1) }
            .compactMap { $0 }

        return applications
    }
    
    private func identifier(of url: URL) -> String {
        guard let contents = NSDictionary(contentsOf: url.appendingPathComponent(".com.apple.mobile_container_manager.metadata.plist")),
            let identifier = contents["MCMMetadataIdentifier"] as? String  else {
            return "unknown"
        }
        return identifier
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
