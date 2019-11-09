import XCTest
@testable import VIPER_architecture

class LightSideScreenEntityTests: XCTestCase {
    private var systemUnderTest: LightSideScreenEntity?
    private var jediList: [LightSideScreenEntityType.Jedi]?
    private var jediCode: LightSideScreenEntityType.JediCode?
    
    override func setUp() {
        systemUnderTest = LightSideScreenEntity()
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
        jediList = [
            obiWanKenobi,
            anakinSkywalker
        ]
        
        jediCode = CodeModelFactory.build(
            title: "The Jedi code",
            rules: "There is no emotion, there is peace.\nThere is no ignorance, there is knowledge.\nThere is no passion, there is serenity.\nThere is no chaos, there is harmony.\nThere is no death, there is the Force."
        )
    }
    
    override func tearDown() {
        systemUnderTest = nil
        jediList = nil
        jediCode = nil
    }
    
    func test_setAndGet_jediList() {
        systemUnderTest!.jediList = jediList
        let jediList = systemUnderTest!.jediList
        XCTAssertEqual(jediList?[0].lastName, self.jediList?[0].lastName)
    }
    
    func test_setAndGet_jediCode() {
        systemUnderTest!.jediCode = jediCode
        let jediCode = systemUnderTest!.jediCode
        XCTAssertEqual(jediCode?.rules, self.jediCode?.rules)
    }
    
}
