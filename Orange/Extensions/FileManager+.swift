//
//  FileManager+.swift
//  Orange
//
//  Created by Zhihui Tang on 2022-01-28.
//

import Foundation


extension FileManager {
    
    func applicationPath(of path: String) -> String? {
        allFiles(at: path).filter { URL(fileURLWithPath: $0).pathExtension == "app" }.first
    }

    func allFiles(at path: String) -> [String] {
        (try? FileManager.default.contentsOfDirectory(atPath: path)) ?? []
    }
}
