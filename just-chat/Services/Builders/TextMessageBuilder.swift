import Foundation
import SwiftUI

struct TextMessageBuilder {
    @EnvironmentObject var userSession: UserSession
    
    static let `default` = TextMessageBuilder()
    
    func build(from text: String, and user: AppUser) -> TextMessage {
        var textMessage = TextMessage(type: MessageType.text.get(), content: TextMessageContent(text: text), senderId: user.id)
        textMessage.senderEmail = user.email
        return textMessage
    }
}
