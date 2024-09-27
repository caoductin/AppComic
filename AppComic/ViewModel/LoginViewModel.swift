//
//  LoginViewModel.swift
//  AppComic
//
//  Created by cao duc tin  on 24/9/24.
//

import SwiftUI

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    static var shared: LoginViewModel = LoginViewModel()
    @Published private var userModel: UserModel?

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var user: UserModel?
    @Published var errorMessage: String = ""
    @Published var isShowAlert: Bool = false
    @Published  var isLogin: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
  
    func debugPrint(){
        print(user)
    }
    
    func login() {
            guard !email.isEmpty, !password.isEmpty else {
                errorMessage = "Email and Password are required"
                return
            }
        
            isShowAlert = false
            errorMessage = ""
            
            let parameters: [String: Any] = [
                "email": email,
                "password": password
            ]
            
            ServiceCall.post(parameter: parameters, path: "http://localhost:3000/api/auth/signin", isToken: false, withSuccess: { response in
                // Handle success
//                Swift.debugPrint(response)
                if let response = response as? NSDictionary {
//                    Swift.debugPrint(response)
//                    if response.value(forKey: "status") as? String ?? "" == "200" {
//                        
//                        print("not values for status")
//                        Swift.debugPrint(response)
                        if let response = response  as? [String: Any]{
                            self.userModel = UserModel(dict: response)
                            Swift.debugPrint(self.userModel)
                        }
                        self.isLogin = true
                        
                        
//                    }else{
//                        self.errorMessage = response.value(forKey: "message") as? String ?? "Fail"
//                        self.isShowAlert = true
//                    }
                    //                print("Response: \(response ?? [:])")
                    //                if let response = response  as? [String: Any]{
                    //                    self.userModel = UserModel(dict: response)
                    //                }
                    //                // Process user data
                    //                self.isLoading = false
                    
                }
            }, failure: { error in
                // Handle error
                self.errorMessage = error?.localizedDescription ?? "Unknown error"
                self.isShowAlert = true
            })
        }
    
    // API call function
//    func login() {
//        guard !email.isEmpty, !password.isEmpty else {
//            errorMessage = "Email and Password are required"
//            return
//        }
//        print(email)
//        print(password)
//        
//        isLoading = true
//        errorMessage = ""
//        
//        // Prepare the URL
//        guard let url = URL(string: "http://localhost:3000/api/auth/signin") else {
//            errorMessage = "Invalid URL"
//            return
//        }
//
//        // Create the request body
//        let body: [String: Any] = [
//            "email": email,
//            "password": password
//        ]
//        
//        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {
//            errorMessage = "Invalid request body"
//            return
//        }
//
//        // Create a URLRequest
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = httpBody
//
//        // Use URLSession to make the API request
//        URLSession.shared.dataTaskPublisher(for: request)
//            .tryMap { output -> Data in
//                print(output.response)
//                print(String(data: output.data, encoding: .utf8) ?? "No response data")
//                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
//                    throw URLError(.badServerResponse)
//                }
//                return output.data
//            }
//            .decode(type: UserResponse.self, decoder: JSONDecoder())
//            .map { UserModel(from: $0 ) }
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { [weak self] completion in
//                self?.isLoading = false
//                if case .failure(let error) = completion {
//                    self?.errorMessage = error.localizedDescription
//                }
//            }, receiveValue: { [weak self] user in
//                self?.user = user
//            })
//            .store(in: &cancellables)    }
}
