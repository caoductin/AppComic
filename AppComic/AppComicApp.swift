//
//  AppComicApp.swift
//  AppComic
//
//  Created by cao duc tin  on 23/9/24.
//

import SwiftUI
import SwiftData
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct AppComicApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var loginVM: LoginViewModel = LoginViewModel.shared
    let container = try! ModelContainer(for: PostModelSD.self)
    // Query to count existing posts
    
    @MainActor
    private func importData() async {
        print("importData called")  // Add this line to verify the function is running
        let context = container.mainContext
        
        // Check if there are already posts in the context
        // Use FetchDescriptor to fetch existing posts
        let fetchDescriptor = FetchDescriptor<PostModelSD>()
        let existingPosts: [PostModelSD] = try! context.fetch(fetchDescriptor)
        
        Swift.debugPrint("this is \(existingPosts)")  // This will give you the existing posts
        
//        if !existingPosts.isEmpty {
//            print("Existing posts found in context. Skipping API call.")
//            return // Exit the function if there are existing posts
//        }
        
        
        do {
            let parameters: [String: Any] = [:]
            
            ServiceCall.getComment(parameter: parameters, path: "http://localhost:3000/api/post/getposts", isToken: false, withSuccess: { response in
                print("API called successfully")  // Add this to check if API is called
                if let response = response as? [String: Any],
                   let postsArray = response["posts"] as? [[String: Any]] {
                    
                    let postModels = postsArray.compactMap { PostModelSD(dict: $0 as NSDictionary) }
                    Swift.debugPrint(postModels)
                    
                    Task {
                        @MainActor in
                        postModels.forEach { obj in
                            context.insert(obj)
                        }
                        do {
                            try context.save()
                            print("Context saved")  // Add this to check if context is saved
                        } catch {
                            print("Failed to save context: \(error)")
                        }
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        print("error1")
                    }
                }
            }, failure: { error in
                DispatchQueue.main.async {
                    print("error")
                }
            })
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if !loginVM.isLogin {
                  //  HomeView()
                   LoginView()
//                    CreatePost()
                } else {
                    MainView()
                }
                
            }
            .onAppear {
                Task {
                    await importData()
                    print("Data import task finished")
                }
            }
            
        }
        .modelContainer(for: PostModelSD.self) // Inject SwiftData model container
    }
}
