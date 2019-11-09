import XCTest
@testable import VIPER_architecture

class DarkSideScreenViewTests: XCTestCase {
    func test_viewDidLoad() {
        guard let systemUnderTest = getViewControllerInstance() else {
            return XCTFail()
        }
        
        XCTAssertNotNil(systemUnderTest.view)
        XCTAssertEqual(systemUnderTest.darkSideTitle.text, nil)
        XCTAssertEqual(systemUnderTest.sithCodeTitle.text, nil)
        XCTAssertEqual(systemUnderTest.activityIndicator.isHidden, true)
    }
    
    func test_viewDidAppear() {
        let systemUnderTest = DarkSideScreenView()
        systemUnderTest.presenter = MockDarkSideScreenPresenter()
        systemUnderTest.viewDidAppear(true)
        XCTAssertEqual((systemUnderTest.presenter as! MockDarkSideScreenPresenter).didAppear, true)
    }
    
    func test_viewDidDisappear() {
        let systemUnderTest = DarkSideScreenView()
        systemUnderTest.presenter = MockDarkSideScreenPresenter()
        systemUnderTest.viewDidDisappear(true)
        XCTAssertEqual((systemUnderTest.presenter as! MockDarkSideScreenPresenter).didDisappear, true)
    }
    
    func test_setTitle() {
        guard let systemUnderTest = getViewControllerInstance() else {
            return XCTFail()
        }
        
        XCTAssertNotNil(systemUnderTest.view)
        let expectedTitle = "Welcome to the dark side"
        systemUnderTest.set(title: expectedTitle)
        XCTAssertEqual(systemUnderTest.darkSideTitle.text, expectedTitle)
    }
    
    func test_setSithCode() {
        guard let systemUnderTest = getViewControllerInstance() else {
            return XCTFail()
        }
        
        XCTAssertNotNil(systemUnderTest.view)
        let expectedSithCode = CodeModelFactory.build(
            title: "The Sith code",
            rules: "Peace is a lie, there is only passion.\nThrough passion, I gain strength.\nThrough strength, I gain power.\nThrough power, I gain victory.\nThrough victory, my chains are broken.\nThe Force shall free me."
        )
        systemUnderTest.set(sithCode: expectedSithCode)
        XCTAssertEqual(systemUnderTest.sithCodeTitle.text, expectedSithCode.title)
        XCTAssertEqual(systemUnderTest.sithCodeRules.text, expectedSithCode.rules)
    }
    
    func test_setLoading_true() {
        guard let systemUnderTest = getViewControllerInstance() else {
            return XCTFail()
        }
        
        XCTAssertNotNil(systemUnderTest.view)
        systemUnderTest.set(loading: true)
        XCTAssert(systemUnderTest.activityIndicator.isAnimating)
        XCTAssertFalse(systemUnderTest.activityIndicator.isHidden)
        XCTAssert(systemUnderTest.darkSideTitle.isHidden)
        XCTAssert(systemUnderTest.sithCodeTitle.isHidden)
        XCTAssert(systemUnderTest.sithCodeRules.isHidden)
        XCTAssert(systemUnderTest.sithHolocronListCollectionView.isHidden)
    }
    
    func test_setLoading_false() {
        guard let systemUnderTest = getViewControllerInstance() else {
            return XCTFail()
        }
        
        XCTAssertNotNil(systemUnderTest.view)
        systemUnderTest.set(loading: false)
        XCTAssertFalse(systemUnderTest.activityIndicator.isAnimating)
        XCTAssert(systemUnderTest.activityIndicator.isHidden)
        XCTAssertFalse(systemUnderTest.darkSideTitle.isHidden)
        XCTAssertFalse(systemUnderTest.sithCodeTitle.isHidden)
        XCTAssertFalse(systemUnderTest.sithCodeRules.isHidden)
        XCTAssertFalse(systemUnderTest.sithHolocronListCollectionView.isHidden)
    }
    
    func test_refreshSithHolocronList() {
        guard let systemUnderTest = getViewControllerInstance() else {
            return XCTFail()
        }
        
        XCTAssertNotNil(systemUnderTest.view)
        systemUnderTest.refreshSithHolocronList()
    }
    
    private func getViewControllerInstance() -> DarkSideScreenView? {
        let storyboard = UIStoryboard(name: "DarkSideScreenView", bundle: .main)
        if let viewControllerInstance = storyboard.instantiateViewController(withIdentifier: "DarkSideScreenView") as? DarkSideScreenView {
            return viewControllerInstance
        }
        
        return nil
    }
    
}

class MockDarkSideScreenPresenter: DarkSideScreenPresenterType {
    var view: DarkSideScreenViewType?
    var interactor: DarkSideScreenInteractorType?
    var router: DarkSideScreenRouterType?
    var sithHolocronList: [SithHolocronModel]?
    var didAppear: Bool = false
    var didDisappear: Bool = false
    var lightSideSelected: Bool = false
    
    func viewDidAppear() {
        didAppear = true
    }
    
    func viewDidDisappear() {
        didDisappear = true
    }
    
    func onLightSideSelected() {
        lightSideSelected = true
    }
    
}

