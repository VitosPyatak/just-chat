import SwiftUI

struct ChatView: View {
    @EnvironmentObject var userSession: UserSession
    @ObservedObject var chatViewModel = ChatViewModel()
    @State var currentMessage = ""
    @State var scrolled = false
    

    
    var body: some View {
        VStack {
            ChatHeaderView()
            
            if let user = userSession.appUser {
                MessagesView(user: user)
            }
            
            MessageInputView(userProfile: userSession.userProfile!)
        }
        .ignoresSafeArea()
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
