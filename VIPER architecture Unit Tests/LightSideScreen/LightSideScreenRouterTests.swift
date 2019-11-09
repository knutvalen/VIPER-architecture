import XCTest
import Foundation

@testable import VIPER_architecture

class LightSideScreenRouterTests: XCTestCase {
    func test_create() {
        guard let systemUnderTest = LightSideScreenRouter.create() as? LightSideScreenView else {
            return XCTFail()
        }
        
        XCTAssert(systemUnderTest.presenter is LightSideScreenPresenter)
        XCTAssert(systemUnderTest.presenter?.view is LightSideScreenView)
        XCTAssert(systemUnderTest.presenter?.interactor is LightSideScreenInteractor)
        XCTAssert(systemUnderTest.presenter?.router is LightSideScreenRouter)
        XCTAssert(systemUnderTest.presenter?.interactor?.entity is LightSideScreenEntity)
        XCTAssert(systemUnderTest.presenter?.interactor?.webService is FakeWebService)
    }
    
    func test_routeToDarkSideScreen() {
        let stubLightSideScreenView = StubLightSideScreenView()
        let mockNavigationController = MockUINavigationController(
            rootViewController: stubLightSideScreenView
        )
        let expectation = XCTestExpectation()
        let systemUnderTest = LightSideScreenRouter()
        systemUnderTest.routeToDarkSideScreen(from: stubLightSideScreenView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(2)) {
            XCTAssert(mockNavigationController.pushedViewController is DarkSideScreenView)
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

class StubLightSideScreenView: UIViewController, LightSideScreenViewType {
    var presenter: LightSideScreenPresenterType?
    
    func set(title: String?) {
        
    }
    
    func set(jediCode: CodeModel?) {
        
    }
    
    func set(loading isLoading: Bool) {
        
    }
    
    func refreshJediList() {
        
    }
    
}


