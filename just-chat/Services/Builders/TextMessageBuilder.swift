import Foundation

struct TextMessageBuilder {
    static func build(from text: String) -> TextMessage {
        TextMessage(type: MessageType.text.get(), content: TextMessageContent(text: text))
    }
}
