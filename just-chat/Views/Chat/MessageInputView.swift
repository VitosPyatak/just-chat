//
//  MessageInputView.swift
//  just-chat
//
//  Created by Andrii on 2/1/21.
//

import SwiftUI

struct MessageInputView: View {
    @State var currentMessage: String = ""
    @State var userProfile: UserProfile
    
    var body: some View {
        HStack(spacing: 15) {
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
    
    private func onMessageSend() {
        if !currentMessage.isEmpty {
            ChatHistoryService.default.sendTextMessage(text: $currentMessage.wrappedValue, and: userProfile, completion: onMessageSentCompletion)
        }
        currentMessage = ""
    }
    
    private func onMessageSentCompletion(error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        }
    }
}
