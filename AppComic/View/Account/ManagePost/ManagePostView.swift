//
//  ManagePostView.swift
//  AppComic
//
//  Created by cao duc tin  on 5/10/24.
//

import SwiftUI
import SwiftData
struct ManagePostView: View {
    @StateObject var PostViewMD = PostViewModel.shared
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \PostModelSD.createAt, order: .reverse) var PostData: [PostModelSD]

    var body: some View {
        ScrollView(showsIndicators:false){
            
            VStack(alignment:.leading){
                ForEach(PostViewMD.postModel,id: \.id){
                    post in
                    PostCellForManageView(post: post) {
                        PostViewMD.deletePost(postId: post.id)
                    } onEdit: {
                        
                    }


                    
                    .padding(.vertical,10)
                
                    
                }
            }
        }
    }
}

#Preview {
  
     ManagePostView()
    
}
