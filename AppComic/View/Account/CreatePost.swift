//
//  CreatePost.swift
//  AppComic
//
//  Created by cao duc tin  on 4/10/24.
//
import SwiftUI

import WebKit

struct CreatePost: View {
    @State private var htmlContent: String = ""
    @State private var isPickerPresented = false
    @StateObject private var viewModel = ImagePickerViewModel()
    @StateObject var PostVM = PostViewModel.shared
    @State private var uploadProgress: Double = 0.0
    
    @State private var showCategorySelection = false
    @State private var categories = ["Khoa học", "Du lịch", "thể thao", "Sức khoẻ", "Giáo dục"]
    var body: some View {
        ZStack{
            VStack{
                
                CustomTextField(lable: "Title post", txt: $PostVM.title, title: "Enter the title for the post", keyboardType: .default)
                    .padding()
                Button {
                    isPickerPresented = true
                } label: {
                    if let image = viewModel.selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                    } else {
                        Text("Select an Image")
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(8)
                    }
                }

              
                
                HStack(spacing:40){
                    Button(action: {
                        showCategorySelection = true // Shows the confirmation dialog
                    }, label: {
                        Text((PostVM.category!.isEmpty ? "Select Category" : PostVM.category) ?? "Uncategory")
                                           .font(.system(size: 18, weight: .bold, design: .default))
                                           .frame(minWidth: 100, alignment: .center)
                                           .padding()
                                           .background(Color.blue.opacity(0.2))
                                           .cornerRadius(8)
                    })
                    .confirmationDialog("Select a Category", isPresented: $showCategorySelection) {
                                ForEach(categories, id: \.self) { category in
                                    Button(category) {
                                        PostVM.category = category // Assign selected category to the ViewModel
                                    }
                                }
                                Button("Cancel", role: .cancel) {}
                            }
                    
                    Button {
                        viewModel.uploadImageToFirebase()
                        PostVM.image = viewModel.imageURL?.absoluteString
                        print(viewModel.imageURL)
                    } label: {
                        Text("Upload Image")
                            .font(.system(size: 18, weight: .bold, design: .default))
                    }
                  
                }
                
            


                Text(viewModel.uploadStatus)
                    .padding()
                    .foregroundColor(.blue)
                // Display upload progress
                if viewModel.uploadProgress > 0 && viewModel.uploadProgress < 1 {
                    VStack {
                        ProgressView(value: viewModel.uploadProgress)
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                        
                        // Display the percentage as a number
                        Text("\(Int(viewModel.uploadProgress * 100))% uploaded")
                            .padding()
                            .foregroundColor(.blue)
                    }
                }            // Display the uploaded image from the URL
                RichTextEditorView(htmlContent: $htmlContent)
                    .frame(width: .screenWidth)
                    .frame(height: 300)
                    .environment(\.layoutDirection, .leftToRight) // Forces left-to-right text direction
                    .multilineTextAlignment(.leading)
             
            }
            VStack{
                Spacer()
                ButtonCustom(title: "Create a post") {
                    PostVM.content = htmlContent
                    PostVM.CreatePost()
                    print("HTML content: \(htmlContent)")
                }
                .padding(.bottom,30)
            }
              
            
        }
        
        .alert(isPresented: $PostVM.isLoading) {
                     
                 Alert(title: Text("Error"), message: Text( PostVM.errorMessage ), dismissButton: .default(Text("Ok")))
             }
        .sheet(isPresented: $isPickerPresented) {
            ImagePickerView(selectedImage: $viewModel.selectedImage)
        }
        // Update PostMD.image when viewModel.imageURL changes
               .onChange(of: viewModel.imageURL) { old , newURL in
                   if let urlString = newURL?.absoluteString {
                       PostVM.image = urlString
                       print("Image URL updated: \(urlString)")
                   }
               }
               .ignoresSafeArea(.all)
    }
}

#Preview {

        CreatePost()
    
}
