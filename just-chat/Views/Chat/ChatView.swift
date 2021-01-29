import SwiftUI

struct ChatView: View {
    @EnvironmentObject var userSession: UserSession
    @ObservedObject var chatViewModel = ChatViewModel()
    @State var currentMessage = ""
    
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
            
            ScrollView{
                
                VStack(spacing: 15){
                    
                    ForEach(chatViewModel.messages) {msg in
                        
                        Text(msg.content.text)
                        
                    }
                }
                .padding(.vertical)
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

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
