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
        
        let sortedApplications = device.applications.sorted(by: { app1, app2 in
            guard let date1 = app1.modified, let date2 = app2.modified else {
                return false
            }
            return date1 > date2
        })
        for application in sortedApplications {
            let menuItem = AppMenuItem(app: application)
            submenu?.addItem(menuItem)
        }
    }
}
