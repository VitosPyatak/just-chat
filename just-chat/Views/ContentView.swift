//
//  ContentView.swift
//  just-chat
//
//  Created by admin on 28.01.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var userSession: UserSession;
    
    private let chathistoryRepository = ChatHistoryRepository.default
    
    var body: some View {
        if userSession.appUser != nil {
            ChatView()
        } else {
            Button(action: {
                userSession.signIn(email: "test@gmail.com", password: "password") { res, error in
                    print("Success")
                }
            }) {
                Text("Login")
            }
        }
    }
}
