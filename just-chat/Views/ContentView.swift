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
    
    var body: some View {
        
        OnboardingView()
    }
}
