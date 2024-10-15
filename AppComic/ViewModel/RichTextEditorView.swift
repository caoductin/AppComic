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
        <style>
            body {
                direction: ltr;
                text-align: left;
                font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
                font-size: 16px;
            }
            #editor {
                direction: ltr;
                text-align: left;
            }
        </style>
        </head>
        <body>
        <div id="editor"></div>
        <script>
          var quill = new Quill('#editor', {
            theme: 'snow',
            modules: {
                toolbar: [
                    [{ 'direction': 'ltr' }, { 'align': [] }],
                    ['bold', 'italic', 'underline', 'strike'],
                    ['link', 'blockquote', 'code-block']
                ]
            }
          });
          
          quill.on('text-change', function() {
            window.webkit.messageHandlers.htmlContentHandler.postMessage(quill.root.innerHTML);
          });
            // Disable autocorrect in Quill's editor
                    var editor = document.querySelector('#editor');
                    editor.setAttribute('autocorrect', 'off');
                    editor.setAttribute('autocomplete', 'off');
                    editor.setAttribute('autocapitalize', 'off');
                    editor.setAttribute('spellcheck', 'false');
        </script>
        </body>
        </html>
        """

        
        webView.loadHTMLString(htmlString, baseURL: nil)
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let currentHtmlContentScript = "quill.root.innerHTML;"
        uiView.evaluateJavaScript(currentHtmlContentScript) { (result, error) in
            if let currentHtml = result as? String, currentHtml != self.htmlContent {
                let escapedHtmlContent = self.htmlContent
                    .replacingOccurrences(of: "\\", with: "\\\\")
                    .replacingOccurrences(of: "'", with: "\\'")
                    .replacingOccurrences(of: "\n", with: "\\n")
                    .replacingOccurrences(of: "\r", with: "")
                
                let setHtmlContentScript = "quill.root.innerHTML = '\(escapedHtmlContent)';"
                uiView.evaluateJavaScript(setHtmlContentScript, completionHandler: nil)
            }
        }
    }


//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        let setHtmlContentScript = "quill.root.innerHTML = '\(htmlContent)';"
//        uiView.evaluateJavaScript(setHtmlContentScript, completionHandler: nil)
//    }
}
