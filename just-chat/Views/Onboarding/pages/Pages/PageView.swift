//
//  RegisterPageView.swift
//  just-chat
//
//  Created by Andrii on 1/29/21.
//

import SwiftUI

struct PageView: View {
    var header: String
    var imageName: String
    var title: String
    var content: String
    var textColor: Color
    
    let imageWidth: CGFloat = 150
    let textWidth: CGFloat = 350
    
    var body: some View {
        let size = UIImage(named: imageName)!.size
        let aspect = size.width / size.height
        
        VStack(alignment: .center, spacing: 50) {
                        Text(header)
                            .font(Font.system(size: 40, weight: .bold, design: .rounded))
                            .foregroundColor(textColor)
                            .frame(width: textWidth)
                            .multilineTextAlignment(.center)
                        Image(imageName)
                            .resizable()
                            .aspectRatio(aspect, contentMode: .fill)
                            .frame(width: imageWidth, height: imageWidth)
                            .cornerRadius(40)
                            .clipped()
                        VStack(alignment: .center, spacing: 5) {
                            Text(title)
                                .font(Font.system(size: 25, weight: .bold, design: .rounded))
                                .foregroundColor(textColor)
                                .frame(width: 300, alignment: .center)
                                .multilineTextAlignment(.center)
                            Text(content)
                                .font(Font.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(textColor)
                                .frame(width: 300, alignment: .center)
                                .multilineTextAlignment(.center)
                        }
                    }.padding(60)
    }
}

struct RegisterPageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(header: PageViewData.header, imageName: PageViewData.ImageNames.firstScreen, title: PageViewData.Titles.firstScreen, content: PageViewData.Subtitle.firstScreen, textColor: PageViewData.TextColors.firstScreen)
    }
}
