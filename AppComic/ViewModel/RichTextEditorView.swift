//
//  RichTextEditorView.swift
//  AppComic
//
//  Created by cao duc tin  on 10/10/24.
//

import SwiftUI
import WebKit
struct RichTextEditorView: UIViewRepresentable {
    @Binding var htmlContent: String
    
    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        var parent: RichTextEditorView
        
        init(_ parent: RichTextEditorView) {
            self.parent = parent
        }
        
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if message.name == "htmlContentHandler", let html = message.body as? String {
                DispatchQueue.main.async {
                    self.parent.htmlContent = html
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        
        let contentController = webView.configuration.userContentController
        contentController.add(context.coordinator, name: "htmlContentHandler")
        
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
          
          quill.on('text-change', function() {
            window.webkit.messageHandlers.htmlContentHandler.postMessage(quill.root.innerHTML);
          });
        </script>
        </body>
        </html>
        """
        
        webView.loadHTMLString(htmlString, baseURL: nil)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let setHtmlContentScript = "quill.root.innerHTML = '\(htmlContent)';"
        uiView.evaluateJavaScript(setHtmlContentScript, completionHandler: nil)
    }
}
