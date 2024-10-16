//
//  getAllUser.swift
//  AppComic
//
//  Created by cao duc tin  on 4/10/24.
//
import SwiftUI
import PhotosUI
import FirebaseStorage // Make sure Firebase is imported

import SwiftUI


struct CategorySelectionView: View {
    @StateObject private var viewModel = PostViewModel()
    @State private var showCategorySelection = false
    @State private var categories = ["Technology", "Science", "Sports", "Health", "Education"]
    
    var body: some View {
        VStack(spacing: 40) {
            // Button to show category selection
            Button(action: {
                showCategorySelection.toggle() // Toggles the Menu display
            }, label: {
                Text((viewModel.category!.isEmpty ? "Select Category" : viewModel.category) ?? "tin")
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .frame(minWidth: 100, alignment: .center)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
            })
            .padding()
            .actionSheet(isPresented: $showCategorySelection) { // can you confirmationDialog on ios 15 or later
                ActionSheet(title: Text("Select Category"), buttons: createActionSheetButtons())
             
            }
        }
    }
    
    // Create ActionSheet buttons dynamically
    func createActionSheetButtons() -> [ActionSheet.Button] {
        var buttons: [ActionSheet.Button] = categories.map { category in
            .default(Text(category)) {
                viewModel.category = category
            }
        }
        buttons.append(.cancel())
        return buttons
    }
}



#Preview {
    CategorySelectionView()
}
