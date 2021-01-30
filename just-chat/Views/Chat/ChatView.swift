import SwiftUI

struct ChatView: View {
    @EnvironmentObject var userSession: UserSession
    @ObservedObject var chatViewModel = ChatViewModel()
    @State var currentMessage = ""
    
    private let currentId = "1"
    private let messages = [
        TextMessage(id: UUID().uuidString, type: "text", content: TextMessageContent(text: "Hello!"), senderId: "1"),
        TextMessage(id: UUID().uuidString, type: "text", content: TextMessageContent(text: "Hey"), senderId: "2"),
        TextMessage(id: UUID().uuidString, type: "text", content: TextMessageContent(text: "R we goin out tday?"), senderId: "1"),
        TextMessage(id: UUID().uuidString, type: "text", content: TextMessageContent(text: "For sure"), senderId: "2")
    ]
    
    private var chatHistoryService = ChatHistoryService.default
    
    var body: some View {
        VStack {
            HStack{
                Text("Global Chat")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                Spacer(minLength: 0)
            }
            .padding()
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            .background(PageViewData.Colors.thirdScreen)
            
            if let user = userSession.appUser {
                ScrollViewReader{reader in
                                
                                ScrollView{
                                    
                                    VStack(spacing: 15){
                                        
                                        ForEach(chatViewModel.messages.sorted(by: { $0.timestamp < $1.timestamp })) { msg in
                                            
                                            return VStack(alignment: user.id == msg.senderId ? .trailing : .leading, spacing: 5, content: {
                                                            
                                                Text(msg.content.text)
                                                                    .fontWeight(.semibold)
                                                                    .foregroundColor(.white)
                                                                    .padding()
                                                    .background(user.id == msg.senderId ? PageViewData.Colors.thirdScreen : Color.gray)
                                                    .clipShape(ChatBubble(myMsg: user.id == msg.senderId))
                                                
                                                        })
                                            .padding(.horizontal)

                                        }
                                        .onChange(of: messages, perform: { value in
                                            
                                            reader.scrollTo(messages.last!.id,anchor: .bottom)
                                        })
                                    }
                                    .padding(.vertical)
                                }
                            }
            }
            
            
            
            HStack(spacing: 15){
                    
                    TextField("Enter Message", text: $currentMessage)
                        .padding(.horizontal)
                        .frame(height: 45)
                        .background(Color.primary.opacity(0.06))
                        .clipShape(Capsule())
                    
                    if currentMessage != "" {
                        
                        Button(action: onMessageSend, label: {
                            
                            Image(systemName: "paperplane")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                                .frame(width: 45, height: 45)
                                .background(Color.gray)
                                .clipShape(Circle())
                            
                        })
                    }
                }
                .animation(.default)
                .padding()
            
        }
        .ignoresSafeArea()
    }
    
    private func onMessageSend() {
        if !currentMessage.isEmpty {
            chatHistoryService.sendTextMessage(text: $currentMessage.wrappedValue, and: userSession.appUser!, completion: onMessageSentCompletion)
        }
        currentMessage = ""
    }
    
    private func onMessageSentCompletion(error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        }
    }
}

struct ChatBubble: Shape {

    var myMsg : Bool
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight,myMsg ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 15, height: 15))
        
        return Path(path.cgPath)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
