//
//  CommentViewModel.swift
//  AppComic
//
//  Created by cao duc tin  on 28/9/24.
//

import SwiftUI

class CommentViewModel: ObservableObject {
    @Published var user: UserModel?
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var commment: [CommentModel] = []
    
    // New @Published properties for dynamic input
    @Published var content: String = ""
    private var userId: String = ""
    init(){
    }
    
    init(postID: String){
        self.getComment(postId: postID)
        Swift.debugPrint(commment)
    }
    
    func printcommmet(){
        Swift.debugPrint(commment)

    }
    
    func createComment(postId: String){
        isLoading = true
              errorMessage = ""
        if let userId = UserDefaults.standard.string(forKey: "userId"){
            self.userId = userId
            print("userid\(self.userId)")
        }
        else{
            errorMessage = "the userId is not valid"
            print(errorMessage)
            isLoading = false
            return
        }
              // Define the body parameters
        // Define the body parameters
            let parameters: [String: Any] = [
                "content": content,
                "postId": postId,
                "userId": userId
            ]
              
              let pathCreateComment = "http://localhost:3000/api/comment/create"
        // Making the API call using a POST request
                ServiceCall.post(parameter: parameters, path: pathCreateComment, isToken: true, withSuccess: { response in
                    Swift.debugPrint(response)
                    if let responseDict = response as?  NSDictionary {
                        // Assuming the response dictionary contains the newly created comment data
                         let newComment = CommentModel(dict: responseDict)
                        Swift.debugPrint(newComment)
                        DispatchQueue.main.async {
                            // Add the newly created comment to the comment list
                            self.commment.append(newComment)
                            self.isLoading = false
                            
                            print("Comment created: \(newComment.content)")
                        }
                      
                    } else {
                        print("Response is not valid")
                    }
                }, failure: { error in
                    DispatchQueue.main.async {
                        print("Failed to create comment")
                        self.errorMessage = error?.localizedDescription ?? "Unknown error"
                        self.isLoading = false
                    }
                })
            

    }
    
    func getComment(postId: String) {
        isLoading = true
        errorMessage = ""
        
        let parameters: [String: Any] = [:]
        let pathGetCommment = "http://localhost:3000/api/comment/getPostComments/\(postId)"
        
        ServiceCall.getComment(parameter: parameters, path: pathGetCommment, isToken: false, withSuccess: { response in
            // Handle success
            //Swift.debugPrint(response)
            if let response = response as? [NSDictionary]{
                
                let commments = response.compactMap { CommentModel(dict: $0) }
                
                DispatchQueue.main.async {
                                  self.commment = commments
                                  self.isLoading = false
                              }
//                print("this is comment")
//                for comment in commments {
//                    print(comment.content)
//                }
         
                Swift.debugPrint(self.commment)
            }
            else{
                print("phan tich khong thanh cong")
            }
            
        }, failure: { error in
            DispatchQueue.main.async {
                print("fail roi")
                self.errorMessage = error?.localizedDescription ?? "Unknown error"
                self.isLoading = false
            }
        })
    }
}
