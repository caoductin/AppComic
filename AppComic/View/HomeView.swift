//
//  HomeView.swift
//  AppComic
//
//  Created by cao duc tin  on 27/9/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: PostViewModel = PostViewModel.shared
    
    var body: some View {
        ScrollView{
            VStack{
                
                ForEach(viewModel.postModel) { post in
                    NavigationLink {
                        PostDetailView(postDetailVM: post)
                    } label: {
                        PostDisplay(post: post)
                    }

                   
                }
                
            }
        }
        .padding(.top,.topInsets)
        .navigationTitle("")
        .toolbar(.hidden)
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationStack{
        HomeView()
    }
   
}
