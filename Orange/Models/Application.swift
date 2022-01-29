//
//  Application.swift
//  Orange
//
//  Created by Zhihui Tang on 2022-01-27.
//

import AppKit

private let defaultAppIcon = #imageLiteral(resourceName: "default_icon").appIcon()
struct Application {
    //let uuid: String
    let device: Device
    let rootPath: String
    private(set) var bundleDisplayName: String
    let bundleIdentifier: String
    private(set) var version: String? = nil
    private(set) var icon: NSImage? = nil
    //let contentPath: String
    let image: NSImage
    let attributedTitle: NSMutableAttributedString
    let bundleShortVersion: String
    let bundleVersion: String
    
    init?(device: Device, rootPath: String) {
        self.device = device
        self.rootPath = rootPath
        let fileManager = FileManager.default
        //print("rootPath: \(rootPath)")
        guard let appName = fileManager.applicationPath(of: rootPath) else {
            return nil
        }

        let metaData = NSDictionary(contentsOfFile: "\(rootPath)/.com.apple.mobile_container_manager.metadata.plist")
        guard let identifier = metaData?["MCMMetadataIdentifier"] as? String else {
            return nil
        }
        bundleIdentifier = identifier
        
        let appInfoPath = "\(rootPath)/\(appName)/Info.plist"
        print("appInfoPath: \(appInfoPath)")
        
        guard let appInfoDict = NSDictionary(contentsOfFile: appInfoPath),
            let bundleId = appInfoDict["CFBundleIdentifier"] as? String,
            let name = (appInfoDict["CFBundleDisplayName"] as? String) ?? (appInfoDict["CFBundleName"] as? String),
            bundleId == bundleIdentifier else {
                return nil
        }
        bundleDisplayName = name
        
        let shortVersion = appInfoDict["CFBundleShortVersionString"] as? String ?? "NULL"
        let version = appInfoDict["CFBundleVersion"] as? String ?? "NULL"
        bundleShortVersion = shortVersion
        bundleVersion = version

        let title = "\(bundleDisplayName) (\(bundleVersion)-\(bundleShortVersion))"
        let subTitle = "\n\(bundleIdentifier)"
        attributedTitle = NSMutableAttributedString(string: title + subTitle)
        attributedTitle.addAttributes([NSAttributedString.Key.font: NSFont.systemFont(ofSize: 13)], range: NSRange(location: 0, length: name.count))
        attributedTitle.addAttributes([NSAttributedString.Key.font: NSFont.systemFont(ofSize: 11), NSAttributedString.Key.foregroundColor: NSColor.lightGray], range: NSRange(location: title.count, length: subTitle.count))
        
        let iconFiles = ((appInfoDict["CFBundleIcons"] as? NSDictionary)?["CFBundlePrimaryIcon"] as? NSDictionary)?["CFBundleIconFiles"] as? [String]
        if let iconFile = iconFiles?.last,
            let bundle = Bundle(path: "\(rootPath)/\(appName)"),
            let icon = bundle.image(forResource: iconFile) {
            image = icon.appIcon()
        }else{
            image = defaultAppIcon
        }
    }
}

extension Application {
    
    var bundleContainerPath: String {
        ""
    }
    
    func launch() {
        if device.state == .shutdown {
            try? device.boot()
        }
        shell("/usr/bin/xcrun", arguments: "simctl", "launch", device.udid, bundleIdentifier)
    }
    
    func terminate() {
        shell("/usr/bin/xcrun", arguments: "simctl", "terminate", device.udid, bundleIdentifier)
    }
    
    func uninstall() {
        self.terminate()
        shell("/usr/bin/xcrun", arguments: "simctl", "uninstall", device.udid, bundleIdentifier)
    }
}
