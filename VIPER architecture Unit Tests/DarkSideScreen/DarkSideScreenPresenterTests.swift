import XCTest
@testable import VIPER_architecture

class DarkSideScreenPresenterTests: XCTestCase {
    private var systemUnderTest: DarkSideScreenPresenter?
    
    override func setUp() {
        systemUnderTest = DarkSideScreenPresenter()
        systemUnderTest?.view = MockDarkSideScreenView()
        systemUnderTest?.interactor = MockDarkSideScreenInteractor()
        systemUnderTest?.router = MockDarkSideScreenRouter()
    }
    
    override func tearDown() {
        systemUnderTest = nil
    }
    
    func test_viewDidAppear() {
        systemUnderTest!.viewDidAppear()
        XCTAssert((systemUnderTest?.view as! MockDarkSideScreenView).isLoading!)
        XCTAssert((systemUnderTest?.interactor as! MockDarkSideScreenInteractor).didGetCodeWithCache!)
        XCTAssert((systemUnderTest?.interactor as! MockDarkSideScreenInteractor).didGetSithHolocronListWithCache!)
    }
    
    func test_viewDidDisappear() {
        systemUnderTest!.viewDidDisappear()
        XCTAssertNil((systemUnderTest?.view as! MockDarkSideScreenView).sithCode)
        XCTAssertNil((systemUnderTest?.view as! MockDarkSideScreenView).title)
        XCTAssert((systemUnderTest?.view as! MockDarkSideScreenView).didRefreshSithHolocronList!)
    }
    
    func test_onLightSideSelected() {
        systemUnderTest!.onLightSideSelected()
        XCTAssert((systemUnderTest?.router as! MockDarkSideScreenRouter).didRouteToLightSideScreen!)
    }
    
    func test_get_sithHolocronList() {
        let sithHolocronList = systemUnderTest!.sithHolocronList
        XCTAssertNil(sithHolocronList)
    }
    
}

class MockDarkSideScreenView: DarkSideScreenViewType {
    var presenter: DarkSideScreenPresenterType?
    var title: String?
    var sithCode: CodeModel?
    var isLoading: Bool?
    var didRefreshSithHolocronList: Bool?
    
    func set(title: String?) {
        self.title = title
    }
    
    func set(sithCode: CodeModel?) {
        self.sithCode = sithCode
    }
    
    func set(loading isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    func refreshSithHolocronList() {
        self.didRefreshSithHolocronList = true
    }
    
}

class MockDarkSideScreenInteractor: DarkSideScreenInteractorType {
    var entity: DarkSideScreenEntityType?
    var webService: WebServiceType?
    var didGetCodeWithCache: Bool?
    var didGetSithHolocronListWithCache: Bool?
    
    func getCode(completionHandler: @escaping SithCodeResponse, useCache: Bool) {
        didGetCodeWithCache = useCache
    }
    
    func getSithHolocronList(completionHandler: @escaping SithHolocronListResponse, useCache: Bool) {
        didGetSithHolocronListWithCache = useCache
    }
    
}

class MockDarkSideScreenRouter: DarkSideScreenRouterType {
    var didRouteToLightSideScreen: Bool?
    
    static func create() -> UIViewController {
        return UIViewController()
    }
    
    func routeToLightSideScreen(from view: DarkSideScreenViewType?) {
        didRouteToLightSideScreen = true
    }
    
}
