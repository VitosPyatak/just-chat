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
    
    private func onMessageReceived(message: TextMessage?, error: Error?) {
        if let newMessage = message {
            messages.append(newMessage)
        }
    }
}
