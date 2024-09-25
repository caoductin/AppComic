//
//  SignUpViewModel.swift
//  AppComic
//
//  Created by cao duc tin  on 25/9/24.
//

import SwiftUI

class SignUpViewModel: ObservableObject {
    static var shared: SignUpViewModel = SignUpViewModel()
    @Published private var userModel: UserModel?
    @Published var txtuserName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var user: UserModel?
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    
    func debugPrint(){
        print(user)
    }
    
    func login() {
        guard !email.isEmpty, !password.isEmpty , !txtuserName.isEmpty else {
            errorMessage = "Email and Password are required"
            return
        }
        
        isLoading = true
        errorMessage = ""
        
        let parameters: [String: Any] = [
            "username":txtuserName,
            "email": email,
            "password": password
        ]
        
        ServiceCall.post(parameter: parameters, path: "http://localhost:3000/api/auth/signup", isToken: false, withSuccess: { response in
            // Handle success
            print("Response: \(response ?? [:])")
            if let response = response  as? [String: Any]{
                self.userModel = UserModel(dict: response)
            }
            // Process user data
            self.isLoading = false
            
        }, failure: { error in
            // Handle error
            self.errorMessage = error?.localizedDescription ?? "Unknown error"
            self.isLoading = false
        })
    }
}
