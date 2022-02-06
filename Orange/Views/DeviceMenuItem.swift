//
//  DeviceMenuItem.swift
//  Orange
//
//  Created by Zhihui Tang on 2022-02-04.
//

import Foundation
import AppKit

class DeviceMenuItem: NSMenuItem {
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ runtime: Runtime, device: Device) {
        super.init(title: "\(device.name) (v\(runtime.version))", action: nil, keyEquivalent: "")
        self.onStateImage = NSImage.init(named: NSImage.statusAvailableName)
        self.offStateImage = nil
        self.state = device.state == .shutdown ? .off : .on
        self.submenu = NSMenu()
        
        for application in device.applications {
            let menuItem = AppMenuItem(app: application)
            submenu?.addItem(menuItem)
        }
    }
}
