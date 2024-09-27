//
//  AppComicApp.swift
//  AppComic
//
//  Created by cao duc tin  on 23/9/24.
//

import SwiftUI

@main
struct AppComicApp: App {
    @StateObject var loginVM: LoginViewModel = LoginViewModel.shared
    var body: some Scene {
        WindowGroup {
            NavigationStack{

                if loginVM.isLogin {
                    SignUpView()
                }
                else{
                     MainView()
                }
            }
        
        }
    }
}

