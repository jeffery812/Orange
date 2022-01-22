//
//  StatusItemManager.swift
//  Orange
//
//  Created by Zhihui Tang on 2022-01-21.
//

import Cocoa

class StatusItemManager {
    private let statusItem: NSStatusItem
    private var systemItems = [ NSMenuItem(title: "Preferences...", action: #selector(preference(_:)), keyEquivalent: ","),
                          NSMenuItem(title: "Refresh", action: #selector(refresh(_:)), keyEquivalent: "r"),
                          NSMenuItem(title: "Quit", action: #selector(quitApp(_:)), keyEquivalent: "q") ]

    init() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        let menu = NSMenu()
        systemItems.forEach{
            menu.addItem($0)
            $0.target = self
        }
        statusItem.menu = menu
        statusItem.button?.image = NSImage(named:NSImage.Name("statusItem_icon"))
        let simulator = SimulatorManager().getAllSimulators()
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
