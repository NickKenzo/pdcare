//
//  PDCareUITests.swift
//  PDCareUITests
//
//  Created by Russell Ho on 2019-10-25.
//  Copyright © 2019 PDCare. All rights reserved.
//
//  This file is our UI test. It runs through all buttons and checks UI functionality.
//
//  Change history and authors who worked on this file can
//  be found in the Git history here:
//  https://github.com/NickKenzo/pdcare/edit/Version1/PDCareUITests/PDCareUITests.swift
//

import XCTest

class PDCareUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        let playButton = app.buttons["Play"]
        XCTAssertTrue(playButton.exists)
        playButton.tap()
        XCTAssertTrue(app.navigationBars["PDCare.GamesMenuVC"].buttons["PDCare"].exists)
        app.navigationBars["PDCare.GamesMenuVC"].buttons["PDCare"].tap()
        XCTAssertTrue(playButton.exists)
        playButton.tap()
        XCTAssertTrue(app.buttons["Balance"].exists)

        XCTAssertTrue(app.buttons["DNE"].exists)
    }

}
