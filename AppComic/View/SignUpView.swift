//
//  SignUpView.swift
//  AppComic
//
//  Created by cao duc tin  on 25/9/24.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var signupVM = SignUpViewModel.shared;
    private var strength: Int {
        return calculateStrength(for: signupVM.password)
      }
    private func calculateStrength(for password: String) -> Int {
           var strengthScore = 0
           
           // Add points based on criteria
           if password.count >= 8 { strengthScore += 1 }
           if password.range(of: "[A-Z]", options: .regularExpression) != nil { strengthScore += 1 }
           if password.range(of: "[0-9]", options: .regularExpression) != nil { strengthScore += 1 }
           if password.range(of: "[^a-zA-Z0-9]", options: .regularExpression) != nil { strengthScore += 1 }
           
           // Return a score between 0 and 4
           return strengthScore
       }
       
       
       // Change color based on strength
       private func strengthColor(for strength: Int) -> Color {
           switch strength {
           case 4: return .green
           case 3: return .yellow
           case 2: return .orange
           case 1: return .red
           default: return .gray
           }
       }
    var body: some View {
        VStack(spacing: 20) {
            Text("Sign up")
                .font(.system(size: 30, weight: .bold, design: .serif))
                .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
            Text("Please enter your details")
                .foregroundStyle(.gray.opacity(0.6))
                .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
            CustomTextField(lable: "Enter user name", txt: $signupVM.txtuserName, title: "User Name")
            CustomTextField(lable: "Enter Email", txt: $signupVM.email, title: "Email")
            CustomSecureField(lable: "At least 8 character", txt: $signupVM.password, title: "Password")
            
                       HStack(spacing: 4) {
                           ForEach(0..<4) { index in
                               Rectangle()
                                   .fill(index < strength ? strengthColor(for: strength) : Color.gray.opacity(0.3))
                                   .frame(height: 8)
                                   .cornerRadius(2)
                           }
                       }
                       .padding(.top, 8)
            
            Text("Forgot password?")
                .font(.system(size: 18, weight: .bold, design: .default))
                .foregroundStyle(.gray.opacity(0.9))
                .frame(minWidth: 0,maxWidth: .infinity,alignment: .trailing)
            
            ButtonCustom(title: "Sign Up") {
                signupVM.login()
                print(signupVM.errorMessage)
                
            }
            
            
            ZStack{
                Divider()
                    .frame(height: 1) // Ensure the line is thin
                    .background(Color.gray.opacity(0.4))
                Text("Or Login With ")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.gray.opacity(0.6))
                    .padding(.horizontal, 10) // Add padding around the text
                    .background(Color.white)
            }
            
            
            
            HStack(spacing: 20){
                Image("facebook")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30,height: 30)
                    .padding(.horizontal,30)
                    .padding(.vertical,10)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                
                
                Image("google")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30,height: 30)
                    .padding(.horizontal,30)
                    .padding(.vertical,10)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                
                Image(systemName: "applelogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30,height: 30)
                    .padding(.horizontal,30)
                    .padding(.vertical,10)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                
                
            }
        
        }
        .padding()
        
    }
}

#Preview {
    SignUpView()
}
