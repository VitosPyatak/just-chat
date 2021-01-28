import Foundation

struct TextMessageContent: Codable {
    var text: String
    
    enum CodingKeys: String, CodingKey {
        case text
    }
}
