//
//  CreatePost.swift
//  AppComic
//
//  Created by cao duc tin  on 4/10/24.
//

import SwiftUI
//
//struct CreatePost: View {
//    @State private var htmlString: String = "<p>Type your <b>HTML</b> text here!</p>"
//    
//    var body: some View {
//        VStack {
//            HStack {
//                Button("B") {
//                    // Bold action
//                    toggleBold()
//                }
//                .padding()
//                .background(Color.blue.opacity(0.2))
//                .cornerRadius(5)
//
//                Button("I") {
//                    // Italic action
//                    toggleItalic()
//                }
//                .padding()
//                .background(Color.blue.opacity(0.2))
//                .cornerRadius(5)
//
//                Button("A+") {
//                    // Increase font size action
//                    increaseFontSize()
//                }
//                .padding()
//                .background(Color.blue.opacity(0.2))
//                .cornerRadius(5)
//                
//                Button("A-") {
//                    // Decrease font size action
//                    decreaseFontSize()
//                }
//                .padding()
//                .background(Color.blue.opacity(0.2))
//                .cornerRadius(5)            }
//
//            HTMLTextView(htmlText: $htmlString)
//                .frame(height: 300)
//                .border(Color.gray, width: 1)
//
//            Button(action: {
//                print("Submitted HTML: \(htmlString)")
//            }) {
//                Text("Submit")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//            .padding()
//        }
//        .padding()
//    }
//
//    private func decreaseFontSize() {
//          htmlString = htmlString.replacingOccurrences(of: "</span>", with: "").replacingOccurrences(of: "<span style=\"font-size: 1.5em;\">", with: "")
//          htmlString = "<span style=\"font-size: 0.8em;\">\(htmlString)</span>"
//      }
//
//      private func toggleBold() {
//          if htmlString.contains("<b>") {
//              htmlString = htmlString.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
//          } else {
//              htmlString = "<b>\(htmlString)</b>"
//          }
//      }
//
//      private func toggleItalic() {
//          if htmlString.contains("<i>") {
//              htmlString = htmlString.replacingOccurrences(of: "<i>", with: "").replacingOccurrences(of: "</i>", with: "")
//          } else {
//              htmlString = "<i>\(htmlString)</i>"
//          }
//      }
//
//      private func increaseFontSize() {
//          htmlString = htmlString.replacingOccurrences(of: "</span>", with: "").replacingOccurrences(of: "<span style=\"font-size: 0.8em;\">", with: "")
//          htmlString = "<span style=\"font-size: 1.5em;\">\(htmlString)</span>"
//      }
//}

struct CreatePost: View {
    @State private var htmlString: String = "<p>Previous <b>HTML</b> text!</p>"  // Previous text (HTML string)
    @State private var currentText: String = ""  // This will store new user input
    @State private var currentFontSize: String = "1em"  // Font size for new text
    @State private var isBold: Bool = false  // Bold state
    @State private var isItalic: Bool = false  // Italic state
    
    var body: some View {
        VStack {
            // Font styling buttons
            HStack {
                Button("B") {
                    isBold.toggle()
                }
                .padding()
                .background(isBold ? Color.blue.opacity(0.5) : Color.blue.opacity(0.2))
                .cornerRadius(5)

                Button("I") {
                    isItalic.toggle()
                }
                .padding()
                .background(isItalic ? Color.blue.opacity(0.5) : Color.blue.opacity(0.2))
                .cornerRadius(5)

                Button("A+") {
                    increaseFontSize()
                }
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(5)
                
                Button("A-") {
                    decreaseFontSize()
                }
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(5)
            }

            // Display the HTML preview
            HTMLTextView(htmlText: $htmlString)
                .frame(height: 300)
                .border(Color.gray, width: 1)

            // Text input field for new text
            TextField("Type new text here...", text: $currentText, onCommit: applyFormatting)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocorrectionDisabled(true) // Disable auto-correction

            Button(action: {
                applyFormatting()
            }) {
                Text("Submit")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
    }
    
    // Apply the current formatting to the new text and add it to the htmlString
    private func applyFormatting() {
        var formattedText = currentText
        
        if isBold {
            formattedText = "<b>\(formattedText)</b>"
        }
        
        if isItalic {
            formattedText = "<i>\(formattedText)</i>"
        }
        
        formattedText = "<span style=\"font-size: \(currentFontSize);\">\(formattedText)</span>"
        
        htmlString += formattedText
        currentText = ""  // Reset the input field after applying formatting
    }

    private func increaseFontSize() {
        currentFontSize = "1.5em"
    }

    private func decreaseFontSize() {
        currentFontSize = "0.8em"
    }
}
#Preview {
    CreatePost()
}
