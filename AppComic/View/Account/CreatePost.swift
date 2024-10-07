//
//  CreatePost.swift
//  AppComic
//
//  Created by cao duc tin  on 4/10/24.
//
import SwiftUI

import WebKit

struct RichTextEditorView: UIViewRepresentable {
    @Binding var htmlContent: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        // Load HTML content that includes a rich text editor like Quill
        let htmlString = """
        <!DOCTYPE html>
        <html>
        <head>
        <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
        <script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
        </head>
        <body>
        <div id="editor"></div>
        <script>
          var quill = new Quill('#editor', {
            theme: 'snow'
          });

          function getHtmlContent() {
            return quill.root.innerHTML;
          }
        </script>
        </body>
        </html>
        """
        webView.loadHTMLString(htmlString, baseURL: nil)
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        // Run JavaScript to retrieve the HTML content from the editor
        webView.evaluateJavaScript("getHtmlContent()") { result, error in
            if let html = result as? String {
                DispatchQueue.main.async {
                    self.htmlContent = html
                }
            }
        }
    }
}
struct CreatePost: View {
    @State private var htmlContent: String = ""
    
    var body: some View {
        VStack {
            RichTextEditorView(htmlContent: $htmlContent)
                .frame(width: .screenWidth)
                .frame(height: 300)
            Button("Save HTML") {
                print("HTML content: \(htmlContent)")
                // Save the HTML content here
            }
        }
    }
}

#Preview {
    CreatePost()
}
