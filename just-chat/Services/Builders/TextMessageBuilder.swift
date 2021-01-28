import Foundation
import SwiftUI

struct TextMessageBuilder {
    @EnvironmentObject var userSession: UserSession
    
    static let `default` = TextMessageBuilder()
    
    func build(from text: String) -> TextMessage {
        let messageContent = TextMessageContent(text: text)
        let senderId = userSession.appUser!.id
        return TextMessage(type: MessageType.text.get(), content: messageContent, senderId: senderId)
    }
}
