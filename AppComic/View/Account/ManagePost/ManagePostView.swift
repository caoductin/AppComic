//
//  ManagePostView.swift
//  AppComic
//
//  Created by cao duc tin  on 5/10/24.
//

import SwiftUI
import SwiftData
struct ManagePostView: View {
    @ObservedObject var PostViewMD = PostViewModel()
    @State var isDelete: Bool = false
    @State var postToDelete: PostModel? = nil
    @State private var showSearchView = false
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss   
    var body: some View {
        ZStack{
            VStack{
             
                ScrollView(showsIndicators:false){
                    
                    VStack(alignment:.leading){
//                        ForEach(PostViewMD.postModel,id: \.id){
//                            post in
//                            PostCellForManageView(post: post) {
//                                //PostViewMD.deletePost(postId: post.id)
//                                isDelete = true
//                                postToDelete = post
//                            }
//                            
//                            
//                            
//                            .padding(.vertical,10)
//                            
//                            
//                        }
                        ForEach(PostViewMD.postModel.filter { post in
                                                   searchText.isEmpty || post.title.localizedCaseInsensitiveContains(searchText)
                                               }, id: \.id) { post in
                                                   PostCellForManageView(post: post) {
                                                       isDelete = true
                                                       postToDelete = post
                                                   }
                                                   .padding(.vertical, 10)
                                               }
                    }
                }
            }
            .padding(.top,.topInsets + 10)
            VStack{
                HStack{
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                    })
                    Spacer()
                    Button {
                        // Toggle the search bar visibility
                        // Show the search view with animation
                                              withAnimation {
                                                  showSearchView = true
                                              }
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                    }
                    
                }
                .padding(.horizontal,20)
                .background(.white)
                Spacer()
            }
            // Display the search view with animation
                        if showSearchView {
                            SearchView(showSearchView: $showSearchView, searchText: $searchText)
                                .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .opacity))
                                .zIndex(1) // Make sure it appears on top
                        }

        }

        .alert(isPresented: $isDelete) {
                // Show an alert to confirm deletion
                Alert(
                    title: Text("Delete Post"),
                    message: Text("Are you sure you want to delete this post?"),
                    primaryButton: .destructive(Text("Delete")) {
                        if let post = postToDelete {
                            // Perform the delete operation if confirmed
                            PostViewMD.deletePost(postId: post.id)
                            isDelete = false
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        .navigationBarBackButtonHidden()
        .toolbar(.hidden)
      
    }
}


#Preview {
    NavigationStack{
        ManagePostView()
    }
    
}
