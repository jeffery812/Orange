//
//  AppDelegate.swift
//  Orange
//
//  Created by Zhihui Tang on 2022-01-21.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusItemManager: StatusItemManager?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItemManager = StatusItemManager()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}

