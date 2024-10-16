//
//  CreatePost.swift
//  AppComic
//
//  Created by cao duc tin  on 4/10/24.
//
import SwiftUI

import WebKit
import SDWebImageSwiftUI


import SwiftUI
import WebKit
import SDWebImageSwiftUI

struct CreatePost: View {
    // Dismiss environment variable
    @Environment(\.dismiss) var dismiss
    @State private var isPickerPresented = false
    @StateObject private var viewModel = ImagePickerViewModel()
    @StateObject var PostVM = PostViewModel.shared
    @State private var uploadProgress: Double = 0.0
    @State private var showCategorySelection = false
    @State private var categories = ["Khoa học", "Du lịch", "Thể thao", "Sức khoẻ", "Giáo dục","pháp luật"]

    // Optional PostModel for editing an existing post
    var postToEdit: PostModel?

    var body: some View {
        ZStack {
            ScrollView{
                VStack {
                    // Title TextField
                    CustomTextField(lable: "Title post", txt: $PostVM.title, title: "", keyboardType: .default)
                        .padding(.top,.topInsets + 20)
                        .padding()
                    
                    // Image Picker and Display
                    Button {
                        isPickerPresented = true
                    } label: {
                        if let image = viewModel.selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                        } else {
                            if let imageUrl = postToEdit?.image, let url = URL(string: imageUrl) {
                                WebImage(url: URL(string: imageUrl)) { image in
                                    image.resizable()
                                        .scaledToFill()
                                        .frame(width: 200, height: 200)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                } placeholder: {
                                    Rectangle().foregroundColor(.gray)
                                        .frame(width: 200, height: 200)
                                }
                            } else {
                                Text("Select an Image")
                                    .padding()
                                    .background(Color.gray)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    
                    // Category Selection
                    HStack(spacing: 40) {
                        Button(action: {
                            showCategorySelection = true
                        }, label: {
                            Text((PostVM.category?.isEmpty == true ? "Select Category" : PostVM.category) ?? "Uncategorized")
                                .font(.system(size: 18, weight: .bold, design: .default))
                                .frame(minWidth: 100, alignment: .center)
                                .padding()
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(8)
                        })
                        .confirmationDialog("Select a Category", isPresented: $showCategorySelection) {
                            ForEach(categories, id: \.self) { category in
                                Button(category) {
                                    PostVM.category = category
                                }
                            }
                            Button("Cancel", role: .cancel) {}
                        }
                        
                        // Image Upload Button
                        Button {
                            viewModel.uploadImageToFirebase()
                            PostVM.image = viewModel.imageURL?.absoluteString
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
                            Text("\(Int(viewModel.uploadProgress * 100))% uploaded")
                                .padding()
                                .foregroundColor(.blue)
                        }
                    }
                    
                    // Rich Text Editor for HTML content
                    RichTextEditorView(htmlContent: $PostVM.htmlContent) {
                        PostVM.htmlContent = postToEdit?.content ?? ""
                        print("ham call back da chay")
                    }
                    .frame(width: .screenWidth)
                    .frame(height: 300)
                    .environment(\.layoutDirection, .leftToRight)
                    .multilineTextAlignment(.leading)
                    
                }
            }
            
            VStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20,height: 20)
                        .frame(width: .screenWidth,alignment: .leading)

                    
                }
                .padding(.top,.topInsets)
                .padding(.leading,20)
                
                Spacer()
                ButtonCustom(title: postToEdit == nil ? "Create Post" : "Update Post") {
                    PostVM.content = PostVM.htmlContent
                    if let post = postToEdit {
                        // Update post logic
                        // PostVM.updatePost(postId: post.id)
                    } else {
                        PostVM.CreatePost()
                    }
                    print("HTML content: \(PostVM.htmlContent)")
                }
                .padding(.bottom, 30)
                .padding()
            
        }

         
        }
        .sheet(isPresented: $isPickerPresented) {
            ImagePickerView(selectedImage: $viewModel.selectedImage)
        }
        .onChange(of: viewModel.imageURL) { _, newURL in
            if let urlString = newURL?.absoluteString {
                PostVM.image = urlString
                print("Image URL updated: \(urlString)")
            }
        }

        .onAppear {
            // Set the values if editing an existing post
            if let post = postToEdit {
                PostVM.title = post.title
                PostVM.content = post.content
                PostVM.image = post.image
                PostVM.category = post.category ?? ""
                PostVM.htmlContent = post.content // This should set the HTML content for editing
            }
            else{
                PostVM.title = ""
                PostVM.content = ""
                PostVM.image = ""
                PostVM.category = ""
                PostVM.htmlContent = ""
            }
          
            
        }
        .alert(isPresented: $PostVM.isLoading) {
            Alert(title: Text("Error"), message: Text(PostVM.errorMessage), dismissButton: .default(Text("Ok")))
        }
        .navigationBarBackButtonHidden()
        .toolbar(.hidden)
        .ignoresSafeArea(.all)
    }
}


#Preview {

        CreatePost()
    
}
