import Foundation

// TODO: use @DocumentId decorator so Firebase will assign documentId as message.id

struct TextMessage: Identifiable, Codable, Equatable {
    static func == (lhs: TextMessage, rhs: TextMessage) -> Bool {
        lhs.content.text == rhs.content.text && lhs.sender == rhs.sender
    }
    
    var id =  UUID().uuidString
    var type: String
    var content: TextMessageContent
    var sender: UserProfile
    var timestamp = NSDate().timeIntervalSince1970

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case content
        case sender
        case timestamp
    }
}
