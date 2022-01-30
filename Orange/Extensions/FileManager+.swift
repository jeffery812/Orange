//
//  FileManager+.swift
//  Orange
//
//  Created by Zhihui Tang on 2022-01-28.
//

import Foundation


extension FileManager {
    
    func application(of url: URL) -> URL? {
        allFiles(at: url)?.filter { $0.pathExtension == "app" }.first
    }

    func allFiles(at url: URL) -> [URL]? {
        try? FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [.skipsSubdirectoryDescendants, .skipsHiddenFiles])
    }
}
