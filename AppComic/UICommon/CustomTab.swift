//
//  CustomTab.swift
//  AppComic
//
//  Created by cao duc tin  on 26/9/24.
//

import SwiftUI

struct CustomTab: View {
    @Binding var currentTab: TabData
    var backgroundColor:[Color] = [.purple.opacity(0.5),.blue.opacity(0.5),.pink.opacity(0.5)]
    var backgroundLiner:[Color] = [.red.opacity(0.5),.white.opacity(0.5),.yellow.opacity(0.5)]
    var body: some View {
        GeometryReader{ geometry in
            let width = geometry.size.width
            let buttonWidth = width / CGFloat(TabData.allCases.count) // Calculate width for each button
                
            HStack{
                ForEach(TabData.allCases, id:\.rawValue){
                    tab in
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentTab = tab
                        }
                        
                    }, label: {
                        VStack{
                            Image(systemName:tab.rawValue)
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.blue)
                                .frame(width:25)
                                .frame(maxWidth: .infinity)
                                .offset(y: currentTab == tab ? -10 : 0)
                                .padding(.top,5)
                             
                            Text("Home")
                        
                        }
                        
                    })
                    
                    
                }
             
            }
            .background(alignment: .leading) {
                Circle()
                    .fill(.white.opacity(0.5))
                    .frame(width: 50,height: 50)
                    .shadow(color: .black.opacity(0.2 ), radius: 10,x:0 , y:10)
                    .offset(x: indecatorOffset(width: width, buttonWidth: buttonWidth), y: -10)
                    .overlay{
                        Circle()
                            .trim(from: 0,to: CGFloat(0.5))
                            .stroke(
                                LinearGradient(colors: backgroundLiner, startPoint: .trailing, endPoint: .leading)
                            )
                            .rotationEffect(.degrees(90))
                        
                    }
            
                
            }
        }
        .frame(minWidth: 0,maxWidth: .infinity)
        .frame(height: 60)
        .padding(.top,10)
        .background(
            .linearGradient(colors: backgroundColor, startPoint: .leading, endPoint: .trailing)
        )
 
        
    }
    func indecatorOffset(width: CGFloat, buttonWidth: CGFloat) -> CGFloat {
        let index = CGFloat(getIndex())  // Get the index of the current tab
        return index * buttonWidth + (buttonWidth / 2) - 30  // Offset to center the circle under the icon
    }
    
    func getIndex() -> Int{
        switch currentTab {
        case .home:
            0
        case .explore:
            1
        case .new:
            2
        case .account:
            3
        }
    }
}

#Preview {
//    @State var current: TabData = .home
//    return CustomTab(currentTab: $current)
    MainView()
}
