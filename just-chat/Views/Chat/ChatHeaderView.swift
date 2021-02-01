//
//  ChatHeaderView.swift
//  just-chat
//
//  Created by Andrii on 2/1/21.
//

import SwiftUI

struct ChatHeaderView: View {
    var body: some View {
        HStack{
            Text("Global Chat")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.white)
            
            Spacer(minLength: 0)
        }
        .padding()
        .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
        .background(PageViewData.Colors.thirdScreen)
    }
}

struct ChatHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ChatHeaderView()
    }
}
