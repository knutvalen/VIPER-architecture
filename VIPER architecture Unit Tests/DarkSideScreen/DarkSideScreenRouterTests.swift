import XCTest
import Foundation

@testable import VIPER_architecture

class DarkSideScreenRouterTests: XCTestCase {
    func test_create() {
        guard let systemUnderTest = DarkSideScreenRouter.create() as? DarkSideScreenView else {
            return XCTFail()
        }
        
        XCTAssert(systemUnderTest.presenter is DarkSideScreenPresenter)
        XCTAssert(systemUnderTest.presenter?.view is DarkSideScreenView)
        XCTAssert(systemUnderTest.presenter?.interactor is DarkSideScreenInteractor)
        XCTAssert(systemUnderTest.presenter?.router is DarkSideScreenRouter)
        XCTAssert(systemUnderTest.presenter?.interactor?.entity is DarkSideScreenEntity)
        XCTAssert(systemUnderTest.presenter?.interactor?.webService is FakeWebService)
    }
    
    func test_routeToLightSideScreen() {
        let stubDarkSideScreenView = StubDarkSideScreenView()
        let mockNavigationController = MockUINavigationController(
            rootViewController: stubDarkSideScreenView
        )
        let expectation = XCTestExpectation()
        let systemUnderTest = DarkSideScreenRouter()
        systemUnderTest.routeToLightSideScreen(from: stubDarkSideScreenView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(2)) {
            XCTAssert(mockNavigationController.pushedViewController is LightSideScreenView)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    private class MockUINavigationController: UINavigationController {
        var pushedViewController: UIViewController?
        
        override func pushViewController(
            _ viewController: UIViewController,
            animated: Bool)
        {
            pushedViewController = viewController
            super.pushViewController(viewController, animated: animated)
        }
        
    }

}

class StubDarkSideScreenView: UIViewController, DarkSideScreenViewType {
    var presenter: DarkSideScreenPresenterType?
    
    func set(title: String?) {
        
    }
    
    func set(sithCode: CodeModel?) {
        
    }
    
    func set(loading isLoading: Bool) {
        
    }
    
    func refreshSithHolocronList() {
        
    }
    
}
