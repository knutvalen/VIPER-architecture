import XCTest
@testable import VIPER_architecture

class DarkSideScreenEntityTests: XCTestCase {
    private var systemUnderTest: DarkSideScreenEntity?
    private var sithHolocronList: [DarkSideScreenEntityType.SithHolocron]?
    private var sithCode: DarkSideScreenEntityType.SithCode?
    
    override func setUp() {
        systemUnderTest = DarkSideScreenEntity()

        let holocronOfHeresies = SithHolocronModelFactory.build(
            name: "Holocron of Heresies",
            creator: "Darth Andeddu",
            powers: ["Essence transfer"]
        )
        
        let holocronOfNagaSadow = SithHolocronModelFactory.build(
            name: "Holocron of Naga Sadow",
            creator: "Naga Sadow",
            powers: ["Dark rituals", "Sith alchemy"]
        )
        
        sithHolocronList = [
            holocronOfHeresies,
            holocronOfNagaSadow
        ]
        
        sithCode = CodeModelFactory.build(
            title: "The Sith code",
            rules: "Peace is a lie, there is only passion.\nThrough passion, I gain strength.\nThrough strength, I gain power.\nThrough power, I gain victory.\nThrough victory, my chains are broken.\nThe Force shall free me."
        )
    }
    
    override func tearDown() {
        systemUnderTest = nil
        sithHolocronList = nil
        sithCode = nil
    }
    
    func test_setAndGet_jediList() {
        systemUnderTest!.sithHolocronList = sithHolocronList
        let sithHolocronList = systemUnderTest!.sithHolocronList
        XCTAssertEqual(sithHolocronList?[0].creator, self.sithHolocronList?[0].creator)
    }
    
    func test_setAndGet_sithCode() {
        systemUnderTest!.sithCode = sithCode
        let sithCode = systemUnderTest!.sithCode
        XCTAssertEqual(sithCode?.rules, self.sithCode?.rules)
    }
    
}
