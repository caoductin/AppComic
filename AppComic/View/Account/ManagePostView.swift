//
//  ManagePostView.swift
//  AppComic
//
//  Created by cao duc tin  on 5/10/24.
//

import SwiftUI
import SwiftData
struct ManagePostView: View {
    @StateObject var PostViewMD: PostViewModel = PostViewModel()
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \PostModelSD.createAt, order: .reverse) var PostData: [PostModelSD]

    var body: some View {
        ScrollView(showsIndicators:false){
            
            VStack(alignment:.leading){
                ForEach(PostData){
                    post in
                    PostCellForManageView(post: post) {
                        PostViewModel().deletePost(postId: post.id, context: modelContext)
                    }
                
                    
                }
            }
        }
    }
}

#Preview {
    @MainActor
    func setupMockData(context: ModelContext) {
        let mockPosts = PostModelSD.mockData()
        mockPosts.forEach { post in
            context.insert(post)
        }
        mockPosts.forEach{post in
            Swift.debugPrint(post.title)
        }
        do {
            try context.save()
            print("Mock data inserted successfully")
        } catch {
            print("Failed to save mock data: \(error)")
        }
    }
    
    let container = try! ModelContainer(for: PostModelSD.self)
    let context = container.mainContext
    
    setupMockData(context: context)
    return ManagePostView()
        .environment(\.modelContext, context)

}
