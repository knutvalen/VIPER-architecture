import XCTest
@testable import VIPER_architecture

class LightSideScreenInteractorTests: XCTestCase {
    private var systemUnderTest: LightSideScreenInteractor?
    
    override func setUp() {
        systemUnderTest = LightSideScreenInteractor()
        systemUnderTest!.webService = MockWebService()
        systemUnderTest!.entity = MockLightSideScreenEntity()
    }
    
    override func tearDown() {
        systemUnderTest = nil
    }
    
    func test_getCode_noCache_success() {
        let expectedJediCode = CodeModelFactory.build(
            title: "The Jedi code",
            rules: "There is no emotion, there is peace.\nThere is no ignorance, there is knowledge.\nThere is no passion, there is serenity.\nThere is no chaos, there is harmony.\nThere is no death, there is the Force."
        )
        (systemUnderTest?.webService as! MockWebService).jediCode = expectedJediCode
        let expectation = XCTestExpectation()
        systemUnderTest?.getCode(completionHandler: { (jediCode, _) in
            XCTAssertEqual(jediCode?.title, expectedJediCode.title)
            XCTAssertEqual(jediCode?.rules, expectedJediCode.rules)
            expectation.fulfill()
        }, useCache: false)
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_getCode_useCache_success() {
        let expectedJediCode = CodeModelFactory.build(
            title: "The Jedi code",
            rules: "There is no emotion, there is peace.\nThere is no ignorance, there is knowledge.\nThere is no passion, there is serenity.\nThere is no chaos, there is harmony.\nThere is no death, there is the Force."
        )
        (systemUnderTest?.entity as! MockLightSideScreenEntity).jediCode = expectedJediCode
        let expectation = XCTestExpectation()
        systemUnderTest?.getCode(completionHandler: { (jediCode, _) in
            XCTAssertEqual(jediCode?.title, expectedJediCode.title)
            XCTAssertEqual(jediCode?.rules, expectedJediCode.rules)
            expectation.fulfill()
        }, useCache: true)
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_getCode_failure() {
        (systemUnderTest?.webService as! MockWebService).shouldFailWithErrorResponse = .invalidResponse
        let expectation = XCTestExpectation()
        systemUnderTest?.getCode(completionHandler: { (_, error) in
            switch error! {
            case .invalidResponse:
                expectation.fulfill()
            default:
                XCTFail()
            }
        }, useCache: false)
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_getJediList_noCache_success() {
        let obiWanKenobi = JediModelFactory.build(
            firstName: "Obi-Wan",
            lastName: "Kenobi"
        )
        let anakinSkywalker = JediModelFactory.build(
            firstName: "Anakin",
            lastName: "Skywalker"
        )
        
        obiWanKenobi.apprentices = [anakinSkywalker]
        anakinSkywalker.apprentices = [
            JediModelFactory.build(firstName: "Ahsoka", lastName: "Tano")
        ]
        
        let expectedJediList = [
            obiWanKenobi,
            anakinSkywalker
        ]
        (systemUnderTest?.webService as! MockWebService).jediList = expectedJediList
        let expectation = XCTestExpectation()
        systemUnderTest?.getJediList(completionHandler: { (jediList, _) in
            XCTAssertEqual(jediList?[0].firstName, obiWanKenobi.firstName)
            XCTAssertEqual(jediList?[0].lastName, obiWanKenobi.lastName)
            XCTAssertEqual(jediList?[0].apprentices?[0].firstName, anakinSkywalker.firstName)
            XCTAssertEqual(jediList?[0].apprentices?[0].lastName, anakinSkywalker.lastName)
            XCTAssertEqual(jediList?[1].firstName, anakinSkywalker.firstName)
            XCTAssertEqual(jediList?[1].lastName, anakinSkywalker.lastName)
            XCTAssertEqual(jediList?[1].apprentices?[0].firstName, anakinSkywalker.apprentices?[0].firstName)
            XCTAssertEqual(jediList?[1].apprentices?[0].lastName, anakinSkywalker.apprentices?[0].lastName)
            XCTAssertNil(jediList?[1].apprentices?[0].apprentices)
            expectation.fulfill()
        }, useCache: false)
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_getJediList_useCache_success() {
        let obiWanKenobi = JediModelFactory.build(
            firstName: "Obi-Wan",
            lastName: "Kenobi"
        )
        let anakinSkywalker = JediModelFactory.build(
            firstName: "Anakin",
            lastName: "Skywalker"
        )
        
        obiWanKenobi.apprentices = [anakinSkywalker]
        anakinSkywalker.apprentices = [
            JediModelFactory.build(firstName: "Ahsoka", lastName: "Tano")
        ]
        
        let expectedJediList = [
            obiWanKenobi,
            anakinSkywalker
        ]
        (systemUnderTest?.entity as! MockLightSideScreenEntity).jediList = expectedJediList
        let expectation = XCTestExpectation()
        systemUnderTest?.getJediList(completionHandler: { (jediList, _) in
            XCTAssertEqual(jediList?[0].firstName, obiWanKenobi.firstName)
            XCTAssertEqual(jediList?[0].lastName, obiWanKenobi.lastName)
            XCTAssertEqual(jediList?[0].apprentices?[0].firstName, anakinSkywalker.firstName)
            XCTAssertEqual(jediList?[0].apprentices?[0].lastName, anakinSkywalker.lastName)
            XCTAssertEqual(jediList?[1].firstName, anakinSkywalker.firstName)
            XCTAssertEqual(jediList?[1].lastName, anakinSkywalker.lastName)
            XCTAssertEqual(jediList?[1].apprentices?[0].firstName, anakinSkywalker.apprentices?[0].firstName)
            XCTAssertEqual(jediList?[1].apprentices?[0].lastName, anakinSkywalker.apprentices?[0].lastName)
            XCTAssertNil(jediList?[1].apprentices?[0].apprentices)
            expectation.fulfill()
        }, useCache: true)
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_getJediList_failure() {
        (systemUnderTest?.webService as! MockWebService).shouldFailWithErrorResponse = .invalidResponse
        let expectation = XCTestExpectation()
        systemUnderTest?.getJediList(completionHandler: { (_, error) in
            switch error! {
            case .invalidResponse:
                expectation.fulfill()
            default:
                XCTFail()
            }
        }, useCache: false)
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    private class MockWebService: WebServiceType {
        var jediCode: CodeModel?
        var shouldFailWithErrorResponse: ErrorResponse?
        var jediList: [JediModel]?
        
        func request<Response>(path: String, method: String, completion: @escaping (Result<Response, ErrorResponse>) -> Void)
            where Response : Decodable
        {
            if let shouldFailWithErrorResponse = shouldFailWithErrorResponse {
                completion(.failure(shouldFailWithErrorResponse))
                return
            }
            
            let encoder = JSONEncoder()
            var data: Data?
            
            if path.elementsEqual("light-side-service/jedi/code")
                && method.elementsEqual("GET")
            {
                data = try? encoder.encode(jediCode)
            }
            
            if path.elementsEqual("light-side-service/jedi-list")
                && method.elementsEqual("GET")
            {
                data = try? encoder.encode(jediList)
            }
            
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(Response.self, from: data!)
                completion(.success(result))
            } catch let error {
                completion(.failure(.decodeError(error)))
            }
        }
        
    }

    private class MockLightSideScreenEntity: LightSideScreenEntityType {
        var jediCode: JediCode?
        var jediList: [Jedi]?
    }

}

