import Foundation
import SwiftUI

struct TextMessageBuilder {
    @EnvironmentObject var userSession: UserSession
    
    static let `default` = TextMessageBuilder()
    
    func build(from text: String, and user: AppUser) -> TextMessage {
        let messageContent = TextMessageContent(text: text)
        return TextMessage(type: MessageType.text.get(), content: messageContent, senderId: user.id)
    }
}
