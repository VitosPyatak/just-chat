//
//  MessagesView.swift
//  just-chat
//
//  Created by Andrii on 2/1/21.
//

import SwiftUI
import Combine

struct MessagesView: View {
    @ObservedObject var chatViewModel = ChatViewModel()
    @State var user: AppUser
    
    var body: some View {
        ScrollViewReader { reader in
            ScrollView {
                VStack(spacing: 15) {
                    
                    ForEach(chatViewModel.messages.sorted(by: { $0.timestamp < $1.timestamp })) { msg in
                        VStack(spacing: 5, content: {
                            Text(msg.sender.username)
                            HStack {
                                Text(msg.content.text)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(user.id == msg.sender.userId ? PageViewData.Colors.thirdScreen : Color.gray)
                                    .clipShape(ChatBubble(myMsg: user.id == msg.sender.userId))
                                    .id(msg.id)
                                ImageURL(msg.sender.imageUrl)
                                    .cornerRadius(100.0)
                            }
                        })
                        .padding(.horizontal)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: user.id == msg.sender.userId ? .trailing : .leading)

                    }
                    .onChange(of: chatViewModel.messages, perform: { value in
                        reader.scrollTo(chatViewModel.messages.last!.id, anchor: .bottom)
                    })
                }
                .padding(.vertical)
            }
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

struct ImageURL: View {
    @ObservedObject var imageModel: ImageModel

    private let imageSide: CGFloat = 50

    init(_ imageUrl: String) {
        self.imageModel = ImageModel(imageURL: imageUrl)
    }

    var body: some View {
        Image(uiImage: imageModel.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: imageSide, height: imageSide)
    }
}


//struct MessagesView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessagesView()
//    }
//}
