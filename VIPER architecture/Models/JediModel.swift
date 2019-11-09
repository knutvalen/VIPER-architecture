import Foundation

class JediModel: Codable {
    var firstName: String?
    var lastName: String?
    var apprentices: [JediModel]?
    
    init(firstName: String?, lastName: String?, apprentices: [JediModel]?) {
        self.firstName = firstName
        self.lastName = lastName
        self.apprentices = apprentices
    }
    
    enum CodingKeys: CodingKey {
        case firstName
        case lastName
        case apprentices
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        apprentices = try container.decodeIfPresent([JediModel].self, forKey: .apprentices)
    }
    
}
