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
        self.getComment(postId: "66f630eba86c6bd5bef81e48")
        self.likeComment(commentID: "66fa518639a96b4b46303431")
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
    
    func likeComment(commentID: String){
        isLoading = true
        errorMessage = ""
        let parameters: [String: Any] = [:]
        let pathLikeCommment = "http://localhost:3000/api/comment/likeComment/\(commentID)"
            
            ServiceCall.putComment(parameter: parameters, path: pathLikeCommment, isToken: true, withSuccess: { response in
                // Handle success
                print("like comment was run")
                Swift.debugPrint(response)
                print("this is self.comment\(self.commment)")
                if let response = response as? NSDictionary{
                    
                    if let index = self.commment.firstIndex(where: { $0.id == "\(commentID)" }) {
                        // Update the comment at the found index
                        let updatedComment = CommentModel(dict: response)
                        Swift.debugPrint("this is update comment:\(updatedComment)")
                        self.commment[index] = updatedComment
                        
                    }
                    else{
                        print("this is not runt")
                    }
                    print("this is not runt")
                    Swift.debugPrint(self.commment)
                }
                else{
                    print("reponse khong phai la 1 api")
                }
                
            }, failure: { error in
                DispatchQueue.main.async {
                    print("fail roi")
                    self.errorMessage = error?.localizedDescription ?? "Unknown error"
                    self.isLoading = false
                }
            })
        
    }
    
    func getComment(postId: String) {
        isLoading = true
        errorMessage = ""
        
        let parameters: [String: Any] = [:]
        
        let pathGetCommnet = Globs.GetPost_URL + postId
        
        ServiceCall.getComment(parameter: parameters, path: pathGetCommnet, isToken: false, withSuccess: { response in
            // Handle success
            //Swift.debugPrint(response)
            if let response = response as? [NSDictionary]{
                
                let commments = response.compactMap { CommentModel(dict: $0) }
                
                DispatchQueue.main.async {
                                  self.commment = commments
                                  self.isLoading = false
                              }
                         
                Swift.debugPrint("this is selfcommnet in get commne \(self.commment)")
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
