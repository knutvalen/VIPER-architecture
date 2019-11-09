import XCTest
@testable import VIPER_architecture

class DarkSideScreenInteractorTests: XCTestCase {
    private var systemUnderTest: DarkSideScreenInteractor?
    
    override func setUp() {
        systemUnderTest = DarkSideScreenInteractor()
        systemUnderTest!.webService = MockWebService()
        systemUnderTest!.entity = MockDarkSideScreenEntity()
    }
    
    override func tearDown() {
        systemUnderTest = nil
    }
    
    func test_getCode_noCache_success() {
        let expectedSithCode = CodeModelFactory.build(
            title: "The Sith code",
            rules: "Peace is a lie, there is only passion.\nThrough passion, I gain strength.\nThrough strength, I gain power.\nThrough power, I gain victory.\nThrough victory, my chains are broken.\nThe Force shall free me."
        )
        (systemUnderTest?.webService as! MockWebService).sithCode = expectedSithCode
        let expectation = XCTestExpectation()
        systemUnderTest?.getCode(completionHandler: { (sithCode, _) in
            XCTAssertEqual(sithCode?.title, expectedSithCode.title)
            XCTAssertEqual(sithCode?.rules, expectedSithCode.rules)
            expectation.fulfill()
        }, useCache: false)
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_getCode_useCache_success() {
        let expectedSithCode = CodeModelFactory.build(
            title: "The Sith code",
            rules: "Peace is a lie, there is only passion.\nThrough passion, I gain strength.\nThrough strength, I gain power.\nThrough power, I gain victory.\nThrough victory, my chains are broken.\nThe Force shall free me."
        )
        (systemUnderTest?.entity as! MockDarkSideScreenEntity).sithCode = expectedSithCode
        let expectation = XCTestExpectation()
        systemUnderTest?.getCode(completionHandler: { (sithCode, _) in
            XCTAssertEqual(sithCode?.title, expectedSithCode.title)
            XCTAssertEqual(sithCode?.rules, expectedSithCode.rules)
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
    
    func test_getSithHolocronList_noCache_success() {
        let expectedSithHolocronList = [
            SithHolocronModelFactory.build(
                name: "Holocron of Heresies",
                creator: "Darth Andeddu",
                powers: ["Essence transfer"]
            ),
            SithHolocronModelFactory.build(
                name: "Holocron of Naga Sadow",
                creator: "Naga Sadow",
                powers: ["Dark rituals", "Sith alchemy"]
            ),
        ]
        
        (systemUnderTest?.webService as! MockWebService).sithHolocronList = expectedSithHolocronList
        let expectation = XCTestExpectation()
        systemUnderTest?.getSithHolocronList(completionHandler: { (sithHolocronList, _) in
            XCTAssertEqual(sithHolocronList?[0].name, expectedSithHolocronList[0].name)
            XCTAssertEqual(sithHolocronList?[0].creator, expectedSithHolocronList[0].creator)
            XCTAssertEqual(sithHolocronList?[0].powers?[0], expectedSithHolocronList[0].powers?[0])
            XCTAssertEqual(sithHolocronList?[1].name, expectedSithHolocronList[1].name)
            XCTAssertEqual(sithHolocronList?[1].creator, expectedSithHolocronList[1].creator)
            XCTAssertEqual(sithHolocronList?[1].powers?[0], expectedSithHolocronList[1].powers?[0])
            XCTAssertEqual(sithHolocronList?[1].powers?[1], expectedSithHolocronList[1].powers?[1])
            expectation.fulfill()
        }, useCache: false)
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_getSithHolocronList_useCache_success() {
        let expectedSithHolocronList = [
            SithHolocronModelFactory.build(
                name: "Holocron of Heresies",
                creator: "Darth Andeddu",
                powers: ["Essence transfer"]
            ),
            SithHolocronModelFactory.build(
                name: "Holocron of Naga Sadow",
                creator: "Naga Sadow",
                powers: ["Dark rituals", "Sith alchemy"]
            ),
        ]
        
        (systemUnderTest?.entity as! MockDarkSideScreenEntity).sithHolocronList = expectedSithHolocronList
        let expectation = XCTestExpectation()
        systemUnderTest?.getSithHolocronList(completionHandler: { (sithHolocronList, _) in
            XCTAssertEqual(sithHolocronList?[0].name, expectedSithHolocronList[0].name)
            XCTAssertEqual(sithHolocronList?[0].creator, expectedSithHolocronList[0].creator)
            XCTAssertEqual(sithHolocronList?[0].powers?[0], expectedSithHolocronList[0].powers?[0])
            XCTAssertEqual(sithHolocronList?[1].name, expectedSithHolocronList[1].name)
            XCTAssertEqual(sithHolocronList?[1].creator, expectedSithHolocronList[1].creator)
            XCTAssertEqual(sithHolocronList?[1].powers?[0], expectedSithHolocronList[1].powers?[0])
            XCTAssertEqual(sithHolocronList?[1].powers?[1], expectedSithHolocronList[1].powers?[1])
            expectation.fulfill()
        }, useCache: true)
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_getSithHolocronList_failure() {
        (systemUnderTest?.webService as! MockWebService).shouldFailWithErrorResponse = .invalidResponse
        let expectation = XCTestExpectation()
        systemUnderTest?.getSithHolocronList(completionHandler: { (_, error) in
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
        var sithCode: CodeModel?
        var shouldFailWithErrorResponse: ErrorResponse?
        var sithHolocronList: [SithHolocronModel]?
        
        func request<Response>(path: String, method: String, completion: @escaping (Result<Response, ErrorResponse>) -> Void)
            where Response : Decodable
        {
            if let shouldFailWithErrorResponse = shouldFailWithErrorResponse {
                completion(.failure(shouldFailWithErrorResponse))
                return
            }
            
            let encoder = JSONEncoder()
            var data: Data?
            
            if path.elementsEqual("dark-side-service/sith/code")
                && method.elementsEqual("GET")
            {
                data = try? encoder.encode(sithCode)
            }
            
            if path.elementsEqual("dark-side-service/sith/holocron-list")
                && method.elementsEqual("GET")
            {
                data = try? encoder.encode(sithHolocronList)
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

    private class MockDarkSideScreenEntity: DarkSideScreenEntityType {
        var sithCode: SithCode?
        var sithHolocronList: [SithHolocron]?
    }
    
}

