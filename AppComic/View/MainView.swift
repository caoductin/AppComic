//
//  HomeView.swift
//  AppComic
//
//  Created by cao duc tin  on 25/9/24.
//

import SwiftUI

struct MainView: View {
    @State var tab: TabData = .home
    var body: some View {
        VStack{
            TabView(selection: $tab,
                    content:  {
                
                LoginView()
                    .tag(TabData.home)
                SignUpView()
                .tag(TabData.explore)
                PostView()
                    .tag(TabData.new)
                
             
                
            })
//
            .tabViewStyle(DefaultTabViewStyle())
                     .onAppear{
                         UIScrollView.appearance().isScrollEnabled = false
                     }
            CustomTab(currentTab:$tab)
        }
        .ignoresSafeArea(.all)
        .navigationBarBackButtonHidden()
        .navigationTitle("")
        .toolbar(.hidden)
    }
}

#Preview {
    MainView()
}
