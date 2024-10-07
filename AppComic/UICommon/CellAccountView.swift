//
//  CellAccountView.swift
//  AppComic
//
//  Created by cao duc tin  on 4/10/24.
//

import SwiftUI

struct CellAccountView: View {
    var imageName: String = "person.crop.circle"
    var title: String = "Profile User"
    var body: some View {
        HStack{
            Image(systemName: imageName)
                .font(.system(size: 20))
                .padding(.trailing,7)
            Text(title)
              
            Spacer()
            Image(systemName: "chevron.forward")
        }
        .padding(.vertical,18)
        .padding(.horizontal,10)
    }
}

#Preview {
    CellAccountView()
}
