//
//  UserViewModel.swift
//  AppComic
//
//  Created by cao duc tin  on 4/10/24.
//

import SwiftUI

class UserViewModel: ObservableObject {
    @Published var user: UserModel = UserModel(dict: [:])
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var allUser:[UserModel] = []
    init(){
        self.getAllUser()
    }
    init(userId: String){
        getUser(userId: userId)
    }
    func getAllUser(){
        isLoading = true
        errorMessage = ""
        
        let parameters: [String: Any] = [:]
        let pathGetAllUser = "http://localhost:3000/api/user/getusers"
        
        ServiceCall.getComment(parameter: parameters, path: pathGetAllUser, isToken: true, withSuccess: { response in
            // Handle success
           
            Swift.debugPrint(response ?? "")
            if let response = response as? NSDictionary{
                
                if let user = response.value(forKey: "users") as? [NSDictionary]{
                    self.allUser = user.compactMap { dict in
                        UserModel(dict: dict as! Dictionary<String,Any>)
                    }
                    print("this is all user")
                    Swift.debugPrint(self.allUser)
                    
                }
                else{
                    print(" khong the casting  [NSDictionary]")
                }
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
    
    func getUser(userId: String){
            isLoading = true
            errorMessage = ""
            
            let parameters: [String: Any] = [:]
            let pathGetCommment = "http://localhost:3000/api/user/\(userId)"
            
            ServiceCall.getComment(parameter: parameters, path: pathGetCommment, isToken: false, withSuccess: { response in
                // Handle success
                print("userModel was run")
                Swift.debugPrint(response)
                if let response = response as? NSDictionary{
                    
                    let user = UserModel(dict: response as! Dictionary<String, Any>)
                    self.user = user
                    print("this is user")
                    Swift.debugPrint(self.user)
       
                             
                  
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
