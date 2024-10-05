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
    
    
    var isEmailValid: Bool {
           // Regular expression for basic email validation
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}"
           let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
           return predicate.evaluate(with: email)
       }
    var isPasswordValid: Bool {
            return password.count >= 8
        }
    func Signup() {
        isLoading = false
        errorMessage = ""
        
        guard !email.isEmpty, !password.isEmpty , !txtuserName.isEmpty else {
            errorMessage = "Email, UserName and Password are required"
            isLoading = true
            return
        }
        guard isEmailValid else {
                    errorMessage = "Please enter a valid email address."
                    isLoading = true
                    return
                }

        guard isPasswordValid else{
                    errorMessage = "Password must be at least 8 characters long."
                    isLoading = true
                    return
                }
 
        
        let parameters: [String: Any] = [
            "username":txtuserName,
            "email": email,
            "password": password
        ]
        
        ServiceCall.postCommment(parameter: parameters, path: Globs.SignUp_URL, isToken: false, withSuccess: { response in
            
            self.isLoading = false  // Stop the loading indicator

             if let jsonResponse = response as? [String: Any],
                let message = jsonResponse["message"] as? String {
                
                 if let success = jsonResponse["success"] as? Int, success == 1 {
                     // Signup successful
                     self.isLoading = true
                     self.errorMessage = message
            
                 } else {
                 
                     self.errorMessage = message
                     self.isLoading = true
                 }
                 
             } else {
                 // If the response structure is unexpected
                 self.isLoading = true
                 self.errorMessage = "Unexpected response format."
             }
        }, failure: { error in
            // Handle error
            self.errorMessage = error?.localizedDescription ?? "Unknown error"
            self.isLoading = true
        })
    }
}
