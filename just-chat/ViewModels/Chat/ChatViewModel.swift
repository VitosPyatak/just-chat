import Foundation
import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var messages: [TextMessage] = []
    
    private var chatHistoryRepository = ChatHistoryRepository.default
    
    init() {
        chatHistoryRepository.registerMessageRecievingListener(onMessageRecieved: onMessageReceived)
    }
    
    private func onMessageReceived(message: TextMessage?, error: Error?) {
        if let newMessage = message {
            messages.append(newMessage)
        }
    }
}
