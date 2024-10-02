//
//  HomeView.swift
//  AppComic
//
//  Created by cao duc tin  on 27/9/24.
//

import SwiftUI


import SwiftUI
import SwiftData

struct HomeView: View {
    @StateObject var viewModel: PostViewModel = PostViewModel.shared
    @State private var currentIndex: Int = 0
    @Environment(\.modelContext) private var modelContext
    
    // Query to fetch saved PostModelSD from SwiftData
    @Query(sort: \PostModelSD.createAt, order: .reverse) var PostData: [PostModelSD]
    var body: some View {
        NavigationStack{
            VStack{
            
                ScrollView{
                    ScrollView(.horizontal, showsIndicators: false) {  // Horizontal ScrollView
                        LazyHStack {
                            ForEach(PostData.indices, id: \.self) { index in
                                HeadlineDisplay(post: PostData[index])
                                    .padding(.horizontal, 8)
                                //fix the HeadlineDisplay
                            }
                        }
                        .padding(.vertical)
                    }
                    HStack(spacing: 8) {
                        ForEach(0..<PostData.count, id: \.self) {
                                        index in
                                        Circle()
                                            .fill(currentIndex == index ? Color.blue : Color.gray) // Change color based on selection
                                            .frame(width: 10, height: 10)
                                            .animation(.easeInOut, value: currentIndex) // Smooth transition
                                    }
                                }
                                .padding(.top, 10) // Add some padding above the dots
                    
              
                    VStack{
                        
                        ForEach(PostData) { post in
                  
                            NavigationLink {
                                PostDetailView(postDetailVM: post,commentVM: CommentViewModel(postID: post.id))
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
        
        return HomeView()
            .environment(\.modelContext, context)
    }
   
}
