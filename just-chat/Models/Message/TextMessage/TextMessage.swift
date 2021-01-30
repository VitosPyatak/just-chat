import Foundation

// TODO: use @DocumentId decorator so Firebase will assign documentId as message.id

let defaultEmail = "test@gmail.com"

struct TextMessage: Identifiable, Codable, Equatable {
    static func == (lhs: TextMessage, rhs: TextMessage) -> Bool {
        lhs.content.text == rhs.content.text && lhs.senderId == rhs.senderId
    }
    
    var id =  UUID().uuidString
    var type: String
    var content: TextMessageContent
    var senderId: String
    var senderEmail: String?
    var timestamp = NSDate().timeIntervalSince1970

    var sender: String {
        senderEmail ?? defaultEmail
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case content
        case senderId
        case timestamp
        case senderEmail
    }
}
