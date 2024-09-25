//
//  CustomTextField.swift
//  AppComic
//
//  Created by cao duc tin  on 24/9/24.
//

import SwiftUI

struct CustomTextField: View {
    var lable: String = "Please enter the name"
    @Binding var txt: String
    var title:String = "Email"
   
    var body: some View {
        VStack{
            Text(title)
                .font(.system(size: 20, weight: .semibold, design: .default))
                .foregroundStyle(.black)
                .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
            
            TextField(lable, text: $txt)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color.gray.opacity(0.2)) // Background color with opacity
                )
        }       

    }
}


struct CustomSecureField: View {
    @State var lable: String = "Please enter the name"
    @Binding var txt: String 
    @State var isCheck: Bool = false
    var title: String = "Password"
    var body: some View {
        VStack{
            Text(title)
                .font(.system(size: 20, weight: .semibold, design: .default))
                .foregroundStyle(.black)
                .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
        HStack{
            if isCheck {
                TextField(lable, text: $txt)
                    .onChange(of: txt) { oldValue, newValue in
                                   // Remove spaces from the input
                                   let filteredValue = newValue.replacingOccurrences(of: " ", with: "")
                                   
                                   // Update txt only if it's different
                                   if filteredValue != newValue {
                                       txt = filteredValue
                                   }
                               }
                    .onSubmit {
                        validate(name: txt)
                    }
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding()
                
                
            }
            else{
                SecureField(lable, text: $txt)
                    .onChange(of: txt) { oldValue, newValue in
                                   // Remove spaces from the input
                                   let filteredValue = newValue.replacingOccurrences(of: " ", with: "")
                                   
                                   // Update txt only if it's different
                                   if filteredValue != newValue {
                                       txt = filteredValue
                                   }
                               }

                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding()
                
                
                
            }
            Button(action: {
                isCheck.toggle()
            }, label: {
                Image(systemName: isCheck ? "eye.fill" : "eye.slash.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width:19)
            })
            
        }
        .padding(.horizontal,12)
        .background(
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.gray.opacity(0.2)) // Background color with opacity
        )
    }
}
}
#Preview {
    @State var txt: String = ""
    return CustomSecureField(txt: $txt)
}
