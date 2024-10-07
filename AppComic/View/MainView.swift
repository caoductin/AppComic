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
                
                HomeView()
                    .tag(TabData.home)
                TabHomeView(selectedCategory: TabCategory.newest.rawValue)
                .tag(TabData.explore)
                PostView()
                    .padding(.top,10)
                    .padding(.bottom,-19)
                    .tag(TabData.new)
                AccountView()
                    .tag(TabData.account)
             
                
            })
//
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
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
