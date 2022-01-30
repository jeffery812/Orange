//
//  AppMenu.swift
//  Orange
//
//  Created by Zhihui Tang on 2022-01-29.
//

import Cocoa

class AppMenu: NSMenu {
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(app: Application) {
        super.init(title: "Actions")
        
        let actions: [AppAction.Type] = [ShowBundleContainerInFinder.self, ShowDataContainerInFinder.self, LaunchApp.self, UninstallApp.self]
        actions.forEach { ActionType in
            let action = ActionType.init(app)
            
            let item = NSMenuItem(title: action.title, action: #selector(ShowBundleContainerInFinder.execute), keyEquivalent: "")
            item.target = action as AnyObject
            item.representedObject = action
            addItem(item)
        }
    }
    
}
