//
//  NanoChallenge07UITests.swift
//  NanoChallenge07UITests
//
//  Created by Victor Assis on 25/06/24.
//

import XCTest

final class NanoChallenge07UITests: XCTestCase {

    
    @MainActor func testSearch() {
        
        let app = XCUIApplication()
        app.launch()
        
        let pesquisaTextField = app.textFields["Search"]
        //pesquisaTextField.tap()
        //app.images["Search"].tap()
        //app.scrollViews.otherElements.buttons["Dated Copper Scepter"].tap()
        //app/*@START_MENU_TOKEN@*/.staticTexts["Elemental"]/*[[".buttons[\"Please choose a data center, Elemental\"].staticTexts[\"Elemental\"]",".staticTexts[\"Elemental\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        pesquisaTextField.tap()
        pesquisaTextField.typeText("Copper")
        
        XCTAssertFalse(app.scrollViews.otherElements.buttons["Dated Copper Scepter"].exists)
                
    }
    
    @MainActor func testSeeInfo() {
        
        let app = XCUIApplication()
        app.launch()
        
        let pesquisaTextField = app.textFields["Search"]
        let elementsQuery = app.scrollViews.otherElements
        //app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["Search"].tap()
        
        pesquisaTextField.tap()
        pesquisaTextField.typeText("Copper")
        elementsQuery.buttons["Dated Copper Scepter"].tap()
        elementsQuery.staticTexts["untradable"].tap()
        XCTAssertFalse(elementsQuery.buttons["Dated Copper Scepter"].exists)
    }
    
    @MainActor func testServerSelaction() {
        
        
        
    }
    
    @MainActor func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

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
