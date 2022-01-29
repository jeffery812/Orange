//
//  AppAction.swift
//  Orange
//
//  Created by Zhihui Tang on 2022-01-29.
//

import Foundation
import AppKit

protocol AppAction {
    init(_ app: Application)
    
    var app: Application { get }
    var title: String { get }
    func execute()
}

class ShowBundleContainerInFinder: AppAction {
    var app: Application
    required init(_ app: Application) {
        self.app = app
    }
    
    var title: String = "Show Bundle Container in Finder"
    
    @objc func execute() {
        NSWorkspace.shared.open(URL(fileURLWithPath: app.rootPath))
    }
}

class ShowDataContainerInFinder: AppAction {
    var app: Application
    required init(_ app: Application) {
        self.app = app
    }
    
    var title: String = "Show Data Container in Finder"
    
    @objc func execute() {
        NSWorkspace.shared.open(URL(fileURLWithPath: app.rootPath))
    }
}

class LaunchApp: AppAction {
    var app: Application
    required init(_ app: Application) {
        self.app = app
    }
    
    var title: String { "Launch \(app.bundleDisplayName)" }
    
    @objc func execute() {
        app.launch()
    }
}


class UninstallApp: AppAction {
    var app: Application
    required init(_ app: Application) {
        self.app = app
    }
    
    var title: String { "Uninstall \(app.bundleDisplayName)" }
    
    @objc func execute() {
        let alert: NSAlert = NSAlert()
        alert.messageText = String(format: "Are you sure you want to uninstall %@ from %@?", app.bundleDisplayName, app.device.name)
        alert.informativeText = "All of data(sandbox/bundle) in this application will be deleted."
        alert.alertStyle = .critical
        alert.addButton(withTitle: "Uninstall")
        alert.addButton(withTitle: "Cancel")
        NSApp.activate(ignoringOtherApps: true)
        let response = alert.runModal()
        if response == NSApplication.ModalResponse.alertFirstButtonReturn {
            app.uninstall()
        }
    }
}
