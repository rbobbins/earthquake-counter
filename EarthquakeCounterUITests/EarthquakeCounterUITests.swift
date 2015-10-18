//
//  EarthquakeCounterUITests.swift
//  EarthquakeCounterUITests
//
//  Created by Rachel Bobbins on 10/17/15.
//  Copyright © 2015 Rachel Bobbins. All rights reserved.
//

import XCTest

class EarthquakeCounterUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
