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
    @State private var uploadProgress: Double = 0.0
    var body: some View {
        VStack {
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
            
            Button("Select Image") {
                isPickerPresented = true
            }
            .padding()
            
            Button("Upload Image") {
                viewModel.uploadImageToFirebase()
            }
            .padding()
            
            Text(viewModel.uploadStatus)
                .padding()
                .foregroundColor(.blue)
            // Display upload progress
            if viewModel.uploadProgress > 0 && viewModel.uploadProgress < 1 {
                VStack {
                    ProgressView(value: viewModel.uploadProgress)
                        .padding()
                    
                    // Display the percentage as a number
                    Text("\(Int(viewModel.uploadProgress * 100))% uploaded")
                        .padding()
                        .foregroundColor(.blue)
                }
            }            // Display the uploaded image from the URL
            if let imageURL = viewModel.imageURL {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView() // Loading indicator while the image is loading
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                    case .failure:
                        Text("Failed to load image")
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            RichTextEditorView(htmlContent: $htmlContent)
                .frame(width: .screenWidth)
                .frame(height: 300)
            Button("Tạo bài báo") {
                print("Button clicked")
                print("HTML content: \(htmlContent)")
                // Save the HTML content here
            }
        }
        .sheet(isPresented: $isPickerPresented) {
            ImagePickerView(selectedImage: $viewModel.selectedImage)
        }
    }
}

#Preview {
    CreatePost()
}
