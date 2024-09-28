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
    
    init(postID: String){
        self.getComment(postId: postID)
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
                
                self.commment = commments
                self.isLoading = false
                print("this is comment")
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
