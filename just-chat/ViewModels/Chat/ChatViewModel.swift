import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var messages: [TextMessage] = []
    

    private var chatHistoryService = ChatHistoryService.default
    
    init() {
        chatHistoryService.registerSnapshotListener(onMessageReceived: onMessageReceived)
    }
    
    deinit {
        chatHistoryService.removeSnaphostListener()
    }
    
    func isMessageSequencial(message: TextMessage) -> Bool {
        if let messageIndex = messages.firstIndex(where: {msg in msg.id == message.id}), messageIndex != messages.startIndex {
            return messages[messageIndex - 1].senderId == message.senderId
        }
        return false
        
    }
    
    private func onMessageReceived(message: TextMessage?, error: Error?) {
        if let newMessage = message {
            messages = messages.sorted(by: { $0.timestamp < $1.timestamp })
            messages.append(newMessage)
        }
    }
}
