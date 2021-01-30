//
//  OnboardingView.swift
//  just-chat
//
//  Created by Andrii on 1/29/21.
//

import SwiftUI
import ConcentricOnboarding

struct OnboardingView: View {
    @EnvironmentObject var userSession: UserSession;
    let defaults = UserDefaults.standard
    
    let colors: [Color] = [
        PageViewData.Colors.firstScreen,
        PageViewData.Colors.secondScreen,
        PageViewData.Colors.thirdScreen
    ]
    
    let pages: [AnyView] = [
        AnyView(PageViewData.Pages.firstScreen),
        AnyView(PageViewData.Pages.secondScreen),
        AnyView(PageViewData.Pages.thirdScreen)
    ]

    var body: some View {
        var onboarding = ConcentricOnboardingView(pages:pages, bgColors: colors)
        
        onboarding.insteadOfCyclingToFirstPage = {
            defaults.setValue(true, forKey: UserDefaultsKeys.onboarding)
            userSession.seenOnboarding = true
        }
        
        return onboarding
    }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
