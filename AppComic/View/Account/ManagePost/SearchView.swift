//
//  SearchView.swift
//  AppComic
//
//  Created by cao duc tin  on 16/10/24.
//

import SwiftUI

import SwiftUI

struct SearchView: View {
    @Binding var showSearchView: Bool
    @Binding var searchText: String
    @Environment(\.dismiss) var dismiss // Used to close the sheet
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        VStack {
            // Search bar container
            HStack {
                TextField("Search...", text: $searchText)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .focused($isTextFieldFocused)
                    .onAppear {
                        isTextFieldFocused = true // Automatically focus TextField
                    }
                    .onSubmit {
                        // Optionally handle search action
                        isTextFieldFocused = false
                    }
                
                // Cancel button to dismiss the search view
                Button(action: {
                    showSearchView = false // Close the search view
                }) {
                    Text("Cancel")
                        .foregroundColor(.blue)
                }
                .padding(.trailing, 10)
            }
            .padding()
            .background(Color.white) // Background for the search bar area
            .shadow(radius: 2)
            
            Spacer()
            // Optionally, show results or suggestions here
            Text("No search results yet")
                .foregroundColor(.gray)
                .padding()
            
            Spacer()
        }
        .background(Color.white.ignoresSafeArea()) // Ensures the entire view is white
        .gesture(
            TapGesture().onEnded {
                // Dismiss the keyboard when tapping outside
                isTextFieldFocused = false
            }
        )
    }
}

#Preview {
    @State var show = true
    @State var searchText = ""
    return SearchView(showSearchView: $show, searchText: $searchText)
}
