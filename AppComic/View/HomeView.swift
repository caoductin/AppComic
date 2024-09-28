//
//  HomeView.swift
//  AppComic
//
//  Created by cao duc tin  on 27/9/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: PostViewModel = PostViewModel.shared
    @State private var currentIndex: Int = 0
    var body: some View {
        NavigationStack{
            VStack{
            
                ScrollView{
                    ScrollView(.horizontal, showsIndicators: false) {  // Horizontal ScrollView
                        LazyHStack {
                            ForEach(viewModel.postModel.indices, id: \.self) { index in
                                HeadlineDisplay(post: viewModel.postModel[index])
                                    .padding(.horizontal, 8)
                            }
                        }
                        .padding(.vertical)
                    }
                    HStack(spacing: 8) {
                                    ForEach(0..<viewModel.postModel.count, id: \.self) { index in
                                        Circle()
                                            .fill(currentIndex == index ? Color.blue : Color.gray) // Change color based on selection
                                            .frame(width: 10, height: 10)
                                            .animation(.easeInOut, value: currentIndex) // Smooth transition
                                    }
                                }
                                .padding(.top, 10) // Add some padding above the dots
                    
                    
                    VStack{
                        
                        ForEach(viewModel.postModel) { post in
                            
                            NavigationLink {
                                var comments = CommentViewModel(postID: post.id)
                                PostDetailView(postDetailVM: post,comment: comments.commment)
                            } label: {
                                PostDisplay(post: post)
                            }
                            
                            
                            
                        }
                        
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
    // Preference Key for tracking the scroll position


#Preview {
    NavigationStack{
        HomeView()
    }
   
}
