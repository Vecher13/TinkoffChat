//
//  Tinkoff_first_appUITests.swift
//  Tinkoff first appUITests
//
//  Created by Ash on 07.05.2021.
//

import XCTest

class TinkoffFirstAppUITests: XCTestCase {

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let profileButton = app.buttons["Profile"]
        _ = profileButton.waitForExistence(timeout: 5.0)
        profileButton.tap()

        let nameTF = app.textFields["name TF"]
        let infoTV = app.textViews["info TV"]
        XCTAssertTrue(nameTF.exists, "TF is not here")
        XCTAssertTrue(infoTV.exists, "TV is not here")
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
