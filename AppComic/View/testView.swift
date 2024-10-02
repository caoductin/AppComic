//
//  testView.swift
//  AppComic
//
//  Created by cao duc tin  on 30/9/24.
//

import SwiftUI
import SwiftData

struct testView: View {
    @Environment(\.modelContext) private var modelContext
    
    // Query to fetch saved PostModelSD from SwiftData
    @Query(sort: \PostModelSD.createAt, order: .reverse) var PostData: [PostModelSD]
    @State private var plainTextContent: Text = Text("")
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(PostData) { post in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(post.title)
                                .font(.headline)
                                .onAppear {
                                    // Convert HTML to plain text and store in the state
                                    plainTextContent = post.content.htmlToString()
                                }
                            plainTextContent
                           // post.content.htmlToString()

                            
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
        
            .navigationTitle("Posts")
            .toolbar(.hidden)
            .navigationBarBackButtonHidden()
        }
        .frame(width: .screenWidth ,height: .screenHeight)
        .clipped()
        .tag(TabData.new)
        .onAppear(perform: {
            
        })
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
    
    return testView()
        .environment(\.modelContext, context)
}
