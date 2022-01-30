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
        
        var allApplications = [Application]()
        for (_, deviceList) in simulatorManager.devices {
            for device in deviceList {
                guard let applications = device.applications else {
                    continue
                }
                allApplications.append(contentsOf: applications)
            }
        }
        for application in allApplications.sorted(by: { app1, app2 in
            guard let date1 = app1.modified, let date2 = app2.modified else {
                return false
            }
            return date1 > date2
        }) {
            menu.addItem(AppMenuItem(app: application))
        }

        systemItems.forEach {
            menu.addItem($0)
            $0.target = self
        }
        statusItem.menu = menu
        statusItem.button?.image = NSImage(named:NSImage.Name("statusItem_icon"))
        statusItem.button?.image?.isTemplate = true
    }
    
    private func getAllApplications() {
        var allApplications = [Application]()
        for (_, deviceList) in simulatorManager.devices {
            for device in deviceList {
                guard let applications = device.applications else {
                    continue
                }
                allApplications.append(contentsOf: applications)
            }
        }
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
