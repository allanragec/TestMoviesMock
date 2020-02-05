//
//  TestFilmesMockUITests.swift
//  TestFilmesMockUITests
//
//  Created by Allan Melo on 04/02/20.
//  Copyright © 2020 Allan Melo. All rights reserved.
//

import XCTest

class TestFilmesMockUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    fileprivate func doPullToRefresh(_ app: XCUIApplication) {
        let cell = app.cells.element(boundBy: 0) // first cell on the page
        
        let rightOffset = CGVector(dx: 0.5, dy: 0.5)
        let downOffset = CGVector(dx: 0.5, dy: 30.0)
        
        let cellFarRightCoordinate = cell.coordinate(withNormalizedOffset: rightOffset)
        let cellFarDownCoordinate = cell.coordinate(withNormalizedOffset: downOffset)
        
        // drag from top to down to refresh
        cellFarRightCoordinate.press(forDuration: 0.001, thenDragTo: cellFarDownCoordinate)
    }
    
    func testExploreAppContent() {
        let app = XCUIApplication()
        app.launch()
        
        doPullToRefresh(app)
        
        let scrollViewsQuery = app.scrollViews
        let tablesQuery = scrollViewsQuery.otherElements.tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Avengers 8"]/*[[".cells.buttons[\"Avengers 8\"]",".buttons[\"Avengers 8\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        doPullToRefresh(app)
        
        app.navigationBars["Avengers 7"].buttons["Movies"].tap()
        
        tablesQuery.buttons["Batman 23"].tap()
        
        doPullToRefresh(app)
        
        app.navigationBars["Batman 23"].buttons["Movies"].tap()
    }
}
