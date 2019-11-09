import XCTest

class VIPER_architecture_UI_Tests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {
        
    }
    
    func test_navigation() {
        let app = XCUIApplication()
        app.launch()
        
        let lightSideTexts = app.staticTexts["Welcome to the light side"]
        let darkSideTexts = app.staticTexts["Welcome to the dark side"]
        
        XCTAssert(app.isDisplayingLightSide)
        
        let expectation1 = expectation(
            for: NSPredicate(format: "exists == true"),
            evaluatedWith: lightSideTexts,
            handler: nil
        )
        
        wait(for: [expectation1], timeout: 5)
        
        app.buttons["Dark side"].tap()
        
        XCTAssert(app.isDisplayingDarkSide)
        
        let expectation2 = expectation(
            for: NSPredicate(format: "exists == true"),
            evaluatedWith: darkSideTexts,
            handler: nil
        )
        
        wait(for: [expectation2], timeout: 5)
        
        app.buttons["Light side"].tap()
        
        XCTAssert(app.isDisplayingLightSide)
        
        let expectation3 = expectation(
            for: NSPredicate(format: "exists == true"),
            evaluatedWith: lightSideTexts,
            handler: nil
        )
        
        wait(for: [expectation3], timeout: 5)
        
        app.buttons["Back"].tap()
        
        XCTAssert(app.isDisplayingDarkSide)
        
        let expectation4 = expectation(
            for: NSPredicate(format: "exists == true"),
            evaluatedWith: darkSideTexts,
            handler: nil
        )
        
        wait(for: [expectation4], timeout: 5)
        
        app.buttons["Back"].tap()
        
        XCTAssert(app.isDisplayingLightSide)
        
        let expectation5 = expectation(
            for: NSPredicate(format: "exists == true"),
            evaluatedWith: lightSideTexts,
            handler: nil
        )
        
        wait(for: [expectation5], timeout: 5)
    }
    
}

extension XCUIApplication {
    var isDisplayingLightSide: Bool {
        return otherElements["lightSideView"].exists
    }
    
    var isDisplayingDarkSide: Bool {
        return otherElements["darkSideView"].exists
    }
    
}
