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

    init() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        simulatorManager = SimulatorManager()
        statusItem.menu = getMenus()
        statusItem.button?.image = NSImage(named:NSImage.Name("statusItem_icon"))
        statusItem.button?.image?.isTemplate = true
    }
    
    private func getMenus() -> NSMenu {
        let menu = NSMenu()
        
        let refreshMenuItem = NSMenuItem(title: "Refresh", action: #selector(refresh(_:)), keyEquivalent: "r")
        menu.addItem(refreshMenuItem)
        refreshMenuItem.target = self
        
        menu.addItem(NSMenuItem.separator())

        for runtime in simulatorManager.runtimes {
            guard let devices = runtime.devices else {
                continue
            }

            for device in devices {
                guard device.applications.isEmpty == false else {
                    continue
                }
                let deviceMenu = DeviceMenuItem(runtime, device: device)
                menu.addItem(deviceMenu)
            }
        }

        menu.addItem(NSMenuItem.separator())
        
        let quitMenuItem = NSMenuItem(title: "Quit", action: #selector(quitApp(_:)), keyEquivalent: "q")
        menu.addItem(quitMenuItem)
        quitMenuItem.target = self
        
        return menu
    }
    
    
    private func getAllApplications() -> [Application] {
        var allApplications = [Application]()
        for (_, deviceList) in simulatorManager.devices {
            for device in deviceList {
                let applications = device.applications
                guard !applications.isEmpty else {
                    continue
                }
                allApplications.append(contentsOf: applications)
            }
        }

        return allApplications.sorted(by: { app1, app2 in
            guard let date1 = app1.modified, let date2 = app2.modified else {
                return false
            }
            return date1 > date2
        })
    }
    
    
    @objc private func refresh(_ sender: Any) {
        simulatorManager.refresh()
        statusItem.menu?.removeAllItems()
        statusItem.menu = getMenus()
    }
    
    @objc private func quitApp(_ sender: Any) {
        NSApp.terminate(nil)
    }
    
    private var preferenceWindowController: NSWindowController?
    @objc private func preference(_ sender: NSMenuItem) {
        
    }
}
