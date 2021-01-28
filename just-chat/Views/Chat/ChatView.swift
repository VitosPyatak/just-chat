import SwiftUI

struct ChatView: View {
    @EnvironmentObject var userSession: UserSession
    @ObservedObject var chatViewModel = ChatViewModel()
    @State var currentMessage = ""
    
    private var chatHistoryService = ChatHistoryService.default
    
    var body: some View {
        VStack {
            
            HStack {
                TextField("type message...", text: $currentMessage)
                Button(action: onMessageSend) {
                    Text("Send message")
                }
            }
            
            ScrollView {
                ForEach(chatViewModel.messages) { message in
                    Text(message.content.text)
                }
            }
        }
    }
    
    private func onMessageSend() {
        if !currentMessage.isEmpty {
            chatHistoryService.sendTextMessage(text: $currentMessage.wrappedValue, and: userSession.appUser!, completion: onMessageSentCompletion)
        }
    }
    
    private func onMessageSentCompletion(error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
