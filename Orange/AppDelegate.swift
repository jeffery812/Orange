//
//  AppDelegate.swift
//  Orange
//
//  Created by Zhihui Tang on 2022-01-21.
//

import Cocoa
import os

let logger = Logger(subsystem: "com.crafttang", category: "Orange")

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusItemManager: MenuManager?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItemManager = MenuManager()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}

