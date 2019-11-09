import Foundation

struct SithHolocronModel: Codable {
    var name: String?
    var creator: String?
    var powers: [String]?
    
    init(name: String?, creator: String?, powers: [String]?) {
        self.name = name
        self.creator = creator
        self.powers = powers
    }
    
    enum CodingKeys: CodingKey {
        case name
        case creator
        case powers
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        creator = try container.decodeIfPresent(String.self, forKey: .creator)
        powers = try container.decodeIfPresent([String].self, forKey: .powers)
    }
    
}
