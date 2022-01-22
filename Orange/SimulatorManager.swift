//
//  SimulatorManager.swift
//  Orange
//
//  Created by Zhihui Tang on 2022-01-22.
//

import Foundation

class SimulatorManager {
    
    func getAllSimulators() {
        let s = shell("/usr/bin/xcrun", arguments: "simctl", "list", "-j")
        print("output: \(s.output)")
        print("error: \(s.error)")
    }
    
    private func shell(_ launchPath: String, arguments: String...) -> (output: String, error: String) {
        let process = Process()
        process.launchPath = launchPath
        process.arguments = arguments
        let outputPipe = Pipe()
        let errorPipe = Pipe()
        process.standardOutput = outputPipe
        process.standardError = errorPipe
        process.launch()
        
        let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: outputData, encoding: String.Encoding.utf8)
        let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
        let error = String(data: errorData, encoding: String.Encoding.utf8)
        
        return (output ?? "", error ?? "")
    }
}
