import SwiftUI

struct ChatView: View {
    @ObservedObject var chatViewModel = ChatViewModel()
    @State var currentMessage = ""
    
    
    private var firebaseRepository = ChatHistoryRepository.default
    
    var body: some View {
        VStack {
            
            HStack {
                TextField("type message...", text: $currentMessage)
                Button(action: {
                    let message = TextMessage(type: "text", content: TextMessageContent(text: $currentMessage.wrappedValue))
                    firebaseRepository.saveMessage(message) { error in
                        if let _ = error {
                            print("Error sending message")
                        }
                    }
                }) {
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
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
