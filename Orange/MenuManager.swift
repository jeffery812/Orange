//
//  StatusItemManager.swift
//  Orange
//
//  Created by Zhihui Tang on 2022-01-21.
//

import Cocoa

class MenuManager {
    private let simulatorManager: SimulatorManager
    private let statusItem: NSStatusItem
    private var systemItems = [ NSMenuItem(title: "Preferences...", action: #selector(preference(_:)), keyEquivalent: ","),
                          NSMenuItem(title: "Refresh", action: #selector(refresh(_:)), keyEquivalent: "r"),
                          NSMenuItem(title: "Quit", action: #selector(quitApp(_:)), keyEquivalent: "q") ]

    init() {
        let menu = NSMenu()
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        simulatorManager = SimulatorManager(json: SimulatorManager.getSimCtrlResult())
        
        for (version, deviceList) in simulatorManager.devices {
            for device in deviceList {
                guard let applications = device.applications else {
                    continue
                }
                print("\(version) == \(applications.count)")
                let simulatorMenuItem = NSMenuItem(title: version, action: nil, keyEquivalent: "")
                menu.addItem(simulatorMenuItem)
                for application in applications {
//                    let simulatorMenuItem = NSMenuItem(title: application.bundleName, action: nil, keyEquivalent: "")
//                    menu.addItem(simulatorMenuItem)
                    menu.addItem(AppMenuItem(app: application     ))
                }
                
            }
        }
        
        systemItems.forEach {
            menu.addItem($0)
            $0.target = self
        }
        statusItem.menu = menu
        statusItem.button?.image = NSImage(named:NSImage.Name("statusItem_icon"))
        logger.log("xcrun loadded, runtimes count: \(self.simulatorManager.devices.count)")
    }
    
    
    @objc private func refresh(_ sender: Any) {
    }
    
    @objc private func quitApp(_ sender: Any) {
        NSApp.terminate(nil)
    }
    
    private var preferenceWindowController: NSWindowController?
    @objc private func preference(_ sender: NSMenuItem) {
        
    }
}
