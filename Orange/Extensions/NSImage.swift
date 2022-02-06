//
//  NSImage.swift
//  Orange
//
//  Created by Zhihui Tang on 2022-01-29.
//

import Cocoa

extension NSImage {
    func appIcon(h:CGFloat = 35) -> NSImage {
        let size = NSSize(width: h, height: h)
        let cornerRadius: CGFloat = h/5
        guard self.isValid else {
            return self
        }
        let newImage = NSImage(size: size)

        self.size = size
        newImage.lockFocus()
        NSGraphicsContext.current?.imageInterpolation = .high
        NSGraphicsContext.saveGraphicsState()
        let path = NSBezierPath(roundedRect: NSRect(origin: NSPoint.zero, size: size), xRadius: cornerRadius, yRadius: cornerRadius)
        path.addClip()
        self.draw(at: NSPoint.zero, from: NSRect(origin: NSPoint.zero, size: size), operation: .copy, fraction: 1.0)
        NSGraphicsContext.restoreGraphicsState()
        newImage.unlockFocus()
        return newImage
    }
}
