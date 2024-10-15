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
    @State var keyboardType: UIKeyboardType = .default
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
                .keyboardType(keyboardType)
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color.gray.opacity(0.2)) // Background color with opacity
                )
        }       

    }
}


struct CustomTextFieldView: View {
    @Binding  var txt: String// To store the text input
    @FocusState private var isTextFieldFocused: Bool  // To track if the text field is focused
    let action: (()-> Void)?

    var body: some View {
        VStack {
            Spacer()
            HStack {
                // Your custom TextField
                TextField("Nhập tin nhắn", text: $txt)
                    .padding()
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.none)
                    .focused($isTextFieldFocused)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.2))
                    )
                    .frame(height: 40)
                    .overlay(
                        HStack {
                            Spacer()  // Push the button to the right side
                            if isTextFieldFocused || !txt.isEmpty {
                                Button(action: {
                                    if let action = action{
                                        action()
                                        submitText()
                                    }
                                    else{
                                        print("chua co action ")
                                    }
                                }) {
                                Image(systemName: "arrowtriangle.forward.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                }
                                .transition(.move(edge: .trailing))  // Smooth transition
                                .animation(.easeInOut, value: isTextFieldFocused || !txt.isEmpty)
                            }
                        }
                        .padding(.trailing, 10)  // Add padding so the button doesn't overlap the text
                    )
            }
            .padding()
            
     
        }
    }
    
    func submitText() {
        // Handle the submit action
        print("Submitted text: \(txt)")
        txt = ""  // Clear text after submitting
        isTextFieldFocused = false  // Remove focus from the text field
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
         
                
                
                
            }
            Button(action: {
                isCheck.toggle()
            }, label: {
                Image(systemName: isCheck ? "eye.slash.circle" : "eye.slash.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height:20)
            })
            
        }
        .padding(.vertical,15)
        .padding(.horizontal,12)
        .frame(maxWidth: .infinity) // Ensures both TextField and SecureField take up equal width
           .overlay(
               RoundedRectangle(cornerRadius: 40)
                   .stroke(Color.gray, lineWidth: 1)
           )
           .animation(.default, value: isCheck)
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
