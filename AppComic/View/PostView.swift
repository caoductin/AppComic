//
//  HomeView.swift
//  AppComic
//
//  Created by cao duc tin  on 26/9/24.
//

import SwiftUI
import SDWebImageSwiftUI

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

                            WebImage(url: URL(string: post.image)) { image in
                                   image.resizable()
                                    .scaledToFill()
                                    .frame(width: .screenWidth - 50,height: 200)
                                    .clipShape(
                                            RoundedRectangle(cornerRadius: 5)
                                                        )
                                    .padding(.horizontal,5)
                               } placeholder: {
                                       Rectangle().foregroundColor(.gray)
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
