//
//  LoginView.swift
//  AppComic
//
//  Created by cao duc tin  on 23/9/24.
//

import SwiftUI
func validate(name: String?) {
    if name != nil {
        print("Valid name: \(name ?? "con cac")")
    } else {
        print("Invalid name components. Please enter a full name.")
    }
}
struct LoginView: View {
    @StateObject var loginVM = LoginViewModel.shared;
    @State var txtUserName: String = ""
    @State var txtPassword: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.system(size: 30, weight: .bold, design: .serif))
                .frame(minWidth: 0,maxWidth: .infinity,alignment: .center)
            Text("Login to continue using the app")
                .foregroundStyle(.gray.opacity(0.6))
                .frame(minWidth: 0,maxWidth: .infinity,alignment: .center)

            CustomTextField(lable: "Enter user name", txt: $loginVM.email, title: "Email")
            CustomSecureField(lable: "**********", txt: $loginVM.password, title: "Password")
           
            Text("Forgot password?")
                .font(.system(size: 18, weight: .bold, design: .default))
                .foregroundStyle(.gray.opacity(0.9))
                .frame(minWidth: 0,maxWidth: .infinity,alignment: .trailing)
        
            
//            NavigationLink {
//                MainView()
//            } label: {
            
                ButtonCustom(title: "Login") {
                    loginVM.login()
                }
//            }
          

            
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
            Text(loginVM.errorMessage)
                .onAppear {
                       print(loginVM.errorMessage)
                   }
            // Optionally, you can add a submit button or other UI elements here
        }
        .alert(isPresented: $loginVM.isShowAlert, content: {
            Alert(title: Text("cao duc tin"), message: Text(loginVM.errorMessage) , dismissButton: .default(Text("Ok")))
        })
        .padding()
    }
}
#Preview {
    NavigationStack{
        LoginView()
    }

}
