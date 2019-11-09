import XCTest
@testable import VIPER_architecture

class LightSideScreenViewTests: XCTestCase {
    func test_viewDidLoad() {
        guard let systemUnderTest = getViewControllerInstance() else {
            return XCTFail()
        }
        
        XCTAssertNotNil(systemUnderTest.view)
        XCTAssertEqual(systemUnderTest.lightSideTitle.text, nil)
        XCTAssertEqual(systemUnderTest.jediCodeTitle.text, nil)
        XCTAssertEqual(systemUnderTest.activityIndicator.isHidden, true)
    }
    
    func test_viewDidAppear() {
        let systemUnderTest = LightSideScreenView()
        systemUnderTest.presenter = MockLightSideScreenPresenter()
        systemUnderTest.viewDidAppear(true)
        XCTAssertEqual((systemUnderTest.presenter as! MockLightSideScreenPresenter).didAppear, true)
    }
    
    func test_viewDidDisappear() {
        let systemUnderTest = LightSideScreenView()
        systemUnderTest.presenter = MockLightSideScreenPresenter()
        systemUnderTest.viewDidDisappear(true)
        XCTAssertEqual((systemUnderTest.presenter as! MockLightSideScreenPresenter).didDisappear, true)
    }
    
    func test_setTitle() {
        guard let systemUnderTest = getViewControllerInstance() else {
            return XCTFail()
        }
        
        XCTAssertNotNil(systemUnderTest.view)
        let expectedTitle = "Welcome to the light side"
        systemUnderTest.set(title: expectedTitle)
        XCTAssertEqual(systemUnderTest.lightSideTitle.text, expectedTitle)
    }
    
    func test_setJediCode() {
        guard let systemUnderTest = getViewControllerInstance() else {
            return XCTFail()
        }
        
        XCTAssertNotNil(systemUnderTest.view)
        let expectedJediCode = CodeModelFactory.build(
            title: "The Jedi code",
            rules: "There is no emotion, there is peace.\nThere is no ignorance, there is knowledge.\nThere is no passion, there is serenity.\nThere is no chaos, there is harmony.\nThere is no death, there is the Force."
        )
        systemUnderTest.set(jediCode: expectedJediCode)
        XCTAssertEqual(systemUnderTest.jediCodeTitle.text, expectedJediCode.title)
        XCTAssertEqual(systemUnderTest.jediCodeRules.text, expectedJediCode.rules)
    }
    
    func test_setLoading_true() {
        guard let systemUnderTest = getViewControllerInstance() else {
            return XCTFail()
        }
        
        XCTAssertNotNil(systemUnderTest.view)
        systemUnderTest.set(loading: true)
        XCTAssert(systemUnderTest.activityIndicator.isAnimating)
        XCTAssertFalse(systemUnderTest.activityIndicator.isHidden)
        XCTAssert(systemUnderTest.lightSideTitle.isHidden)
        XCTAssert(systemUnderTest.jediCodeTitle.isHidden)
        XCTAssert(systemUnderTest.jediCodeRules.isHidden)
        XCTAssert(systemUnderTest.jediListCollectionView.isHidden)
    }
    
    func test_setLoading_false() {
        guard let systemUnderTest = getViewControllerInstance() else {
            return XCTFail()
        }
        
        XCTAssertNotNil(systemUnderTest.view)
        systemUnderTest.set(loading: false)
        XCTAssertFalse(systemUnderTest.activityIndicator.isAnimating)
        XCTAssert(systemUnderTest.activityIndicator.isHidden)
        XCTAssertFalse(systemUnderTest.lightSideTitle.isHidden)
        XCTAssertFalse(systemUnderTest.jediCodeTitle.isHidden)
        XCTAssertFalse(systemUnderTest.jediCodeRules.isHidden)
        XCTAssertFalse(systemUnderTest.jediListCollectionView.isHidden)
    }
    
    func test_refreshJediList() {
        guard let systemUnderTest = getViewControllerInstance() else {
            return XCTFail()
        }
        
        XCTAssertNotNil(systemUnderTest.view)
        systemUnderTest.refreshJediList()
    }
    
    private func getViewControllerInstance() -> LightSideScreenView? {
        let storyboard = UIStoryboard(name: "LightSideScreenView", bundle: .main)
        if let viewControllerInstance = storyboard.instantiateViewController(withIdentifier: "LightSideScreenView") as? LightSideScreenView {
            return viewControllerInstance
        }
        
        return nil
    }
    
}

class MockLightSideScreenPresenter: LightSideScreenPresenterType {
    var view: LightSideScreenViewType?
    var interactor: LightSideScreenInteractorType?
    var router: LightSideScreenRouterType?
    var jediList: [JediModel]?
    var didAppear: Bool = false
    var didDisappear: Bool = false
    var darkSideSelected: Bool = false
    
    func viewDidAppear() {
        didAppear = true
    }
    
    func viewDidDisappear() {
        didDisappear = true
    }
    
    func onDarkSideSelected() {
        darkSideSelected = true
    }
    
}
