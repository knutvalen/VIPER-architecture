import Foundation

struct CodeModel: Codable {
    var title: String?
    var rules: String?
    
    init(title: String?, rules: String?) {
        self.title = title
        self.rules = rules
    }
    
    enum CodingKeys: CodingKey {
        case title
        case rules
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        rules = try container.decodeIfPresent(String.self, forKey: .rules)
    }
    
}
