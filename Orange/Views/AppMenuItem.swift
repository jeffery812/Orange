//
//  AppMenuItem.swift
//  Orange
//
//  Created by Zhihui Tang on 2022-01-29.
//

import Foundation
import AppKit

class AppMenuItem: NSMenuItem {
    init(app: Application) {
        super.init(title: "", action: nil, keyEquivalent: "")
        attributedTitle = app.attributedTitle
        image = app.image
        submenu = AppMenu(app: app)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
