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
    let defaults = UserDefaults.standard
    
    var body: some View {
        if userSession.seenOnboarding ?? false {
            if userSession.appUser != nil {
                ChatView()
            } else {
                LoginView()
            }
        } else {
            OnboardingView()
        }
    }
}
