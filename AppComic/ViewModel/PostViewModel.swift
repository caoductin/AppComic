////
////  PostViewModel.swift
////  AppComic
////
////  Created by cao duc tin  on 26/9/24.
////
//
//import SwiftUI
//
//class PostViewModel: ObservableObject {
//    static var shared: PostViewModel = PostViewModel()
//    @Published  var postModel: [PostModel] = []
//    @Published var txtuserName: String = ""
//    @Published var email: String = ""
//    @Published var password: String = ""
//    @Published var user: UserModel?
//    @Published var errorMessage: String = ""
//    @Published var isLoading: Bool = false
//    
//    init(){
//        self.login()
//    }
//    func debugPrint(){
//        print(user)
//    }
//    
//    func login() {
//        
//        isLoading = true
//        errorMessage = ""
//        
//        let parameters: [String: Any] = [:]
//        
//        ServiceCall.get(parameter: parameters, path: "http://localhost:3000/api/post/getposts", isToken: false, withSuccess: { response in
//            // Handle success
//            if let response = response as? [String: Any],
//                         let payload = response["payload"] as? [String: Any],
//                         let postsArray = payload["posts"] as? [[String: Any]] {
//                          
//                          let postModels = postsArray.compactMap { PostModel(dict: $0) }
//                          DispatchQueue.main.async {
//                              self.postModel = postModels
//                              Swift.debugPrint(self.postModel)
//                              self.isLoading = false
//                          }
//                      } else {
//                          DispatchQueue.main.async {
//                              self.errorMessage = "Invalid response structure"
//                              self.isLoading = false
//                          }
//                      }
//            // Process user data
//            self.isLoading = false
//            
//        }, failure: { error in
//            print("error")
//            // Handle error
//            self.errorMessage = error?.localizedDescription ?? "Unknown error"
//            self.isLoading = false
//        })
//    }
//}
import SwiftUI

class PostViewModel: ObservableObject {
    static var shared: PostViewModel = PostViewModel()
    
    @Published var postModel: [PostModel] = []
    @Published var txtuserName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var user: UserModel?
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    init() {
        self.login()
    }
    
    func login() {
        isLoading = true
        errorMessage = ""
        
        let parameters: [String: Any] = [:]
        
        ServiceCall.get(parameter: parameters, path: "http://localhost:3000/api/post/getposts", isToken: false, withSuccess: { response in
            // Handle success
            if let response = response as? [String: Any],
               let postsArray = response["posts"] as? [[String: Any]] {
                
                let postModels = postsArray.compactMap { PostModel(dict: $0) }
               
                    self.postModel = postModels
                    self.isLoading = false
                    Swift.debugPrint(self.postModel)
                
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Invalid response structure"
                    self.isLoading = false
                }
            }
        }, failure: { error in
            DispatchQueue.main.async {
                self.errorMessage = error?.localizedDescription ?? "Unknown error"
                self.isLoading = false
            }
        })
    }
}
