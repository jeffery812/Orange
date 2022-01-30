//
//  SimulatorManager.swift
//  Orange
//
//  Created by Zhihui Tang on 2022-01-22.
//

import Foundation

class SimulatorManager {
    private var simCtrlResult: SimCtrlResult?
    
    init() {
        simCtrlResult = getSimCtrlResult()
    }
    
    func getSimCtrlResult() -> SimCtrlResult? {
        let result = shell("/usr/bin/xcrun", arguments: "simctl", "list", "-j")
        guard let json = result.output else {
            logger.critical("xcrun failed: \(result.error ?? "unknown")")
            return nil
        }
        
        guard let data = json.data(using: .utf8) else { return nil }
        do {
            return try JSONDecoder().decode(SimCtrlResult.self, from: data)
        } catch {
            logger.error("\(error.localizedDescription)")
            return nil
        }
    }
    
    func refresh() {
        simCtrlResult = getSimCtrlResult()
    }
    
    var devices: [String: [Device]] {
        simCtrlResult?.devices ?? [:]
    }
}

@discardableResult
func shell(_ launchPath: String, arguments: String...) -> (output: String?, error: String?) {
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
    
    return (output, error)
}

