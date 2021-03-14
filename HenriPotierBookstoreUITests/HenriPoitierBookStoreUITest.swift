//
//  HBBookStoreUITest.swift
//  HPBookstoreUITests
//
//  Created by Nabil El khaddari on 13/03/2021.
//

import XCTest

class HBBookStoreUITest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEmptyCard() throws {
        let app = XCUIApplication()
        expectation(for: NSPredicate(format: "count > 1"), evaluatedWith: app.tables.cells, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        
        app.navigationBars["Livres"].buttons["0 🛒"].tap()
        let alert =  app.alerts.firstMatch
       
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: alert, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
    }

}
