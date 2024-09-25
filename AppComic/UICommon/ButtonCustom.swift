//
//  ButtonCustom.swift
//  AppComic
//
//  Created by cao duc tin  on 24/9/24.
//

import SwiftUI

struct ButtonCustom: View {
    var title: String = "title"
    var sizeText: CGFloat = 20
    var startColor: Color = .blue
    var endColor: Color = .blue
    var didAction:(() -> ())?
    var body: some View {
        VStack{
            Button {
                if let didAction = didAction{
                    didAction()
                }
            } label: {
                Text(title)
                    .font(.system(size: CGFloat(sizeText), weight: .bold, design: .default))
                    .foregroundStyle(.white)
                    .padding(.vertical,15)
                    .frame(minWidth: 0,maxWidth: .infinity)
                    .background(
                    RoundedRectangle(cornerSize: CGSize(width: 100, height: 100))
                        .fill(
                            LinearGradient(colors: [startColor,endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        
                    )
            }
           

        }
    }
}

#Preview {
    ButtonCustom()
}
