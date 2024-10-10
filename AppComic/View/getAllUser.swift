//
//  getAllUser.swift
//  AppComic
//
//  Created by cao duc tin  on 4/10/24.
//
import SwiftUI
import PhotosUI
import FirebaseStorage // Make sure Firebase is imported


struct getAllUser: View {
    @State private var isPickerPresented = false
    @StateObject private var viewModel = ImagePickerViewModel()
    
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
            
            // Display the uploaded image from the URL
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
        }
        .sheet(isPresented: $isPickerPresented) {
            ImagePickerView(selectedImage: $viewModel.selectedImage)
        }
    }
}


#Preview {
    getAllUser()
}
