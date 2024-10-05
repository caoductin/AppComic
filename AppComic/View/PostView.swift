//
//  HomeView.swift
//  AppComic
//
//  Created by cao duc tin  on 26/9/24.
//

import SwiftUI


struct PostView: View {
    
    @StateObject var viewModel: PostViewModel = PostViewModel.shared
    
    var body: some View {
        NavigationView {
            VStack {
                
                ScrollView {
                    ForEach(viewModel.postModel) { post in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(post.title)
                                .font(.headline)
                            HTMLTextView(htmlContent: post.content)
                                .scaledToFit()
                                .frame(maxHeight: .infinity)
                         
                            //                                .font(.system(.headline))
                            // Optionally load image if you have image URL
                         
                            AsyncImage(url: URL(string: post.image)) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity)
                             
                            } placeholder: {
                                Color.red
                            }
                            Divider()
                        }
                        .padding()
                    }
                }
                
            }
            .navigationTitle("")
            .toolbar(.hidden)
            .navigationBarBackButtonHidden()

            
        }
        .frame(width: .screenWidth ,height: .screenHeight)
        .clipped()
        .tag(TabData.new)
    }
}

#Preview {
    PostView()
}
