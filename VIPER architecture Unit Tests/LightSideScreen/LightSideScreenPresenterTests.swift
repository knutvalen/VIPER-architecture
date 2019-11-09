import XCTest
@testable import VIPER_architecture

class LightSideScreenPresenterTests: XCTestCase {
    private var systemUnderTest: LightSideScreenPresenter?
    
    override func setUp() {
        systemUnderTest = LightSideScreenPresenter()
        systemUnderTest?.view = MockLightSideScreenView()
        systemUnderTest?.interactor = MockLightSideScreenInteractor()
        systemUnderTest?.router = MockLightSideScreenRouter()
    }
    
    override func tearDown() {
        systemUnderTest = nil
    }
    
    func test_viewDidAppear() {
        systemUnderTest!.viewDidAppear()
        XCTAssert((systemUnderTest?.view as! MockLightSideScreenView).isLoading!)
        XCTAssert((systemUnderTest?.interactor as! MockLightSideScreenInteractor).didGetCodeWithCache!)
        XCTAssert((systemUnderTest?.interactor as! MockLightSideScreenInteractor).didGetJediListWithCache!)
    }
    
    func test_viewDidDisappear() {
        systemUnderTest!.viewDidDisappear()
        XCTAssertNil((systemUnderTest?.view as! MockLightSideScreenView).jediCode)
        XCTAssertNil((systemUnderTest?.view as! MockLightSideScreenView).title)
        XCTAssert((systemUnderTest?.view as! MockLightSideScreenView).didRefreshJediList!)
    }
    
    func test_onDarkSideSelected() {
        systemUnderTest!.onDarkSideSelected()
        XCTAssert((systemUnderTest?.router as! MockLightSideScreenRouter).didRouteToDarkSideScreen!)
    }
    
    func test_get_jediList() {
        let jediList = systemUnderTest!.jediList
        XCTAssertNil(jediList)
    }
    
}

class MockLightSideScreenView: LightSideScreenViewType {
    var presenter: LightSideScreenPresenterType?
    var title: String?
    var jediCode: CodeModel?
    var isLoading: Bool?
    var didRefreshJediList: Bool?
    
    func set(title: String?) {
        self.title = title
    }
    
    func set(jediCode: CodeModel?) {
        self.jediCode = jediCode
    }
    
    func set(loading isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    func refreshJediList() {
        self.didRefreshJediList = true
    }
    
}

class MockLightSideScreenInteractor: LightSideScreenInteractorType {
    var entity: LightSideScreenEntityType?
    var webService: WebServiceType?
    var didGetCodeWithCache: Bool?
    var didGetJediListWithCache: Bool?
    
    func getCode(completionHandler: @escaping JediCodeResponse, useCache: Bool) {
        didGetCodeWithCache = useCache
    }
    
    func getJediList(completionHandler: @escaping JediListResponse, useCache: Bool) {
        didGetJediListWithCache = useCache
    }
    
}

class MockLightSideScreenRouter: LightSideScreenRouterType {
    var didRouteToDarkSideScreen: Bool?
    
    static func create() -> UIViewController {
        return UIViewController()
    }
    
    func routeToDarkSideScreen(from view: LightSideScreenViewType?) {
        didRouteToDarkSideScreen = true
    }
    
}
