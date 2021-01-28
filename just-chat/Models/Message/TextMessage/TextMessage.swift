import Foundation

// TODO: use @DocumentId decorator so Firebase will assign documentId as message.id

struct TextMessage: Identifiable, Codable {
    var id =  UUID().uuidString
    var type: String
    var content: TextMessageContent

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case content
    }
}



//#if DEBUG
func createTestContent(text: String) -> TextMessageContent {
    TextMessageContent(text: text)
}

let testTextMessage = TextMessage(type: "text", content: createTestContent(text: "Test message 1"))
//#endif
