//
//  HomeView.swift
//  AppComic
//
//  Created by cao duc tin  on 27/9/24.
//

import SwiftUI


import SwiftUI
import SwiftData

struct TabHomeView: View {
    @StateObject var viewModel: PostViewModel = PostViewModel.shared
    @State private var currentIndex: Int = 0
    @Environment(\.modelContext) private var modelContext
//    
//    func categoryFilter(for category: String) -> Predicate<PostModelSD> {
//        return #Predicate { post in
//            post.category == category
//        }
//    }
//    // Create a computed property that updates the query based on the selectedCategory
//        @Query var PostData: [PostModelSD]
    var selectedCategory: String  // Accept selected category as a parameter

        // Computed property to filter posts based on the selected category
        @Query(sort: \PostModelSD.createAt, order: .reverse) private var PostData: [PostModelSD]

        // Filtering posts based on the selected category
        private var filteredPosts: [PostModelSD] {
            if(selectedCategory == "Mới nhất"){
                return PostData
            }
            else{
                return PostData.filter { $0.category == selectedCategory }
            }

        }
        
    var body: some View {
        NavigationStack{
            VStack{
            
                ScrollView{
                    ScrollView(.horizontal, showsIndicators: false) {  // Horizontal ScrollView
                        LazyHStack {
                            ForEach(filteredPosts.indices, id: \.self) { index in
                                HeadlineDisplay(post: filteredPosts[index])
                                    .padding(.horizontal, 8)
                                //fix the HeadlineDisplay
                            }
                        }
                        .padding(.vertical)
                    }
                    LazyHStack(spacing: 8) {
                        ForEach(0..<filteredPosts.count, id: \.self) {
                                        index in
                                        Circle()
                                            .fill(currentIndex == index ? Color.blue : Color.gray) // Change color based on selection
                                            .frame(width: 10, height: 10)
                                            .animation(.easeInOut, value: currentIndex) // Smooth transition
                                    }
                                }
                                .padding(.top, 10) // Add some padding above the dots
                    
              
                    VStack{
                        
                        ForEach(filteredPosts) { post in
                  
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
    // Use a NavigationStack as the root view for the preview
    NavigationStack {
        // Use @MainActor to ensure that UI updates are on the main thread
        @MainActor
        func setupMockData(context: ModelContext) {
            let mockPosts = PostModelSD.mockData()
            mockPosts.forEach { post in
                context.insert(post)
            }
            mockPosts.forEach { post in
                Swift.debugPrint(post.title)
            }
            do {
                try context.save()
                print("Mock data inserted successfully")
            } catch {
                print("Failed to save mock data: \(error)")
            }
        }
        
        // Create a model container for PostModelSD
        let container = try! ModelContainer(for: PostModelSD.self)
        let context = container.mainContext
        
        // Setup mock data
        setupMockData(context: context)
        
        // Return the HomeView with the selectedCategory parameter
        return TabHomeView(selectedCategory: "pháp luật") // Pass the desired category here
            .environment(\.modelContext, context)
    }
}

