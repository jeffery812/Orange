//
//  OrangeTests.swift
//  OrangeTests
//
//  Created by Zhihui Tang on 2022-01-21.
//

import XCTest
@testable import Orange

class OrangeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSimCtrlResult() throws {
        let fileName = "simctrl"
        guard let path = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") else {
            fatalError("\(fileName).json not found")
        }
        guard let jsonString = try? String(contentsOfFile: path, encoding: .utf8) else {
            fatalError("Unable to convert \(fileName).json to String")
        }
        let manager = SimulatorManager(json: jsonString)
        XCTAssertEqual(manager.simCtrlResult?.devicetypes.count, 76)
        XCTAssertEqual(manager.simCtrlResult?.runtimes.count, 4)
        XCTAssertEqual(manager.simCtrlResult?.devices.count, 10)
        XCTAssertEqual(manager.simCtrlResult?.pairs.count, 14)
        XCTAssertEqual(manager.simCtrlResult?.pairs["9FDFDF13-96C0-4CDD-9EEE-10DD11C3FC45"]?.watch.name, "Apple Watch Series 6 - 44mm")
        XCTAssertEqual(manager.simCtrlResult?.pairs["9FDFDF13-96C0-4CDD-9EEE-10DD11C3FC45"]?.phone.name, "iPhone 13 Pro Max")
    }
}
