//
//  ContentView.swift
//  just-chat
//
//  Created by admin on 28.01.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    private let chathistoryRepository = ChatHistoryRepository.default
    
    var body: some View {
        Text("Hail, world!")
        Button(action: {
            chathistoryRepository.save(testTextMessage, completion: completionHandler)
        }) {
            Text("Save message")
        }
    }
    
    private func completionHandler(error: Error?) {
        if (error != nil) {
            print("Error")
        }
    }
}
