//
//  PageViewData.swift
//  just-chat
//
//  Created by Andrii on 1/29/21.
//

import Foundation
import SwiftUI
import UIKit

enum PageViewData {
    
    static let header = "Let's connect!"
    
    enum Titles {
        static let firstScreen = "Register"
        static let secondScreen = "Login"
        static let thirdScreen = "Chat"
    }
    
    enum Subtitle {
        static let firstScreen = "Fill the form with email and password."
        static let secondScreen = "Use your email and password from the previous step to login."
        static let thirdScreen = "And that's it, you can chat!"
    }
    
    enum ImageNames {
        static let firstScreen = "onboarding_first_screen"
        static let secondScreen = "onboarding_second_screen"
        static let thirdScreen = "onboarding_third_screen"
    }
    
    enum Colors {
        static let firstScreen = Color(hex: "F38181")
        static let secondScreen = Color(hex: "FCE38A")
        static let thirdScreen = Color(hex: "95E1D3")
    }
    
    enum TextColors {
        static let firstScreen = Color(hex: "FFFFFF")
        static let secondScreen = Color(hex: "4A4A4A")
        static let thirdScreen = Color(hex: "4A4A4A")
    }
    
    enum Pages {
        static let firstScreen = PageView(header: PageViewData.header, imageName: PageViewData.ImageNames.firstScreen, title: PageViewData.Titles.firstScreen, content: PageViewData.Subtitle.firstScreen, textColor: PageViewData.TextColors.firstScreen)
        static let secondScreen = PageView(header: PageViewData.header, imageName: PageViewData.ImageNames.secondScreen, title: PageViewData.Titles.secondScreen, content: PageViewData.Subtitle.secondScreen, textColor: PageViewData.TextColors.secondScreen)
        static let thirdScreen = PageView(header: PageViewData.header, imageName: PageViewData.ImageNames.thirdScreen, title: PageViewData.Titles.thirdScreen, content: PageViewData.Subtitle.thirdScreen, textColor: PageViewData.TextColors.thirdScreen)
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff


        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
}
