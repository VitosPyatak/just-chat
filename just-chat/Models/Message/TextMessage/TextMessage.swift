import Foundation

// TODO: use @DocumentId decorator so Firebase will assign documentId as message.id

struct TextMessage: Identifiable, Codable {
    var id =  UUID().uuidString
    var type: String
    var content: TextMessageContent
    var senderId: String

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case content
        case senderId
    }
}
