//
//  OnboardingView.swift
//  just-chat
//
//  Created by Andrii on 1/29/21.
//

import SwiftUI
import ConcentricOnboarding

struct OnboardingView: View {
    let colors: [Color] = [PageViewData.Colors.firstScreen, PageViewData.Colors.secondScreen, PageViewData.Colors.thirdScreen]
    
    let pages: [AnyView] = [
        AnyView(PageViewData.Pages.firstScreen),
        AnyView(PageViewData.Pages.secondScreen),
        AnyView(PageViewData.Pages.thirdScreen)
    ]

    var body: some View {
        ConcentricOnboardingView(pages:pages, bgColors: colors)
    }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
