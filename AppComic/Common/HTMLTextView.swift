import SwiftUI
import UIKit

//struct HTMLTextView: UIViewRepresentable {
//    let htmlContent: String
//    
//    func makeUIView(context: Context) -> UITextView {
//        let textView = UITextView()
//        textView.isEditable = false
//        textView.isScrollEnabled = true // Enable scrolling for long content
//        textView.backgroundColor = .clear
//        textView.textContainer.lineBreakMode = .byWordWrapping
//        return textView
//    }
//    
//    func updateUIView(_ uiView: UITextView, context: Context) {
//        if let data = htmlContent.data(using: .utf8) {
//            do {
//                let attributedString = try NSAttributedString(data: data,
//                                                              options: [.documentType: NSAttributedString.DocumentType.html,
//                                                                        .characterEncoding: String.Encoding.utf8.rawValue],
//                                                              documentAttributes: nil)
//                uiView.attributedText = attributedString
//            } catch {
//                uiView.text = "Failed to load content"
//            }
//        }
//    }
//}

import SwiftUI
import UIKit

struct HTMLTextView: UIViewRepresentable {
    @Binding var htmlText: String
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: HTMLTextView

        init(parent: HTMLTextView) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            // Update the HTML string whenever the text view content changes
            if let htmlData = textView.attributedText?.toHTML() {
                parent.htmlText = htmlData
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.autocorrectionType = .no
        textView.attributedText = NSAttributedString(htmlString: htmlText)
        
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = NSAttributedString(htmlString: htmlText)
    }
}

// Extend NSAttributedString to convert HTML to NSAttributedString
extension NSAttributedString {
    convenience init?(htmlString: String) {
        guard let data = htmlString.data(using: .utf8) else {
            return nil
        }
        
        do {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            try self.init(data: data, options: options, documentAttributes: nil)
        } catch {
            return nil
        }
    }
}

// Convert NSAttributedString back to HTML
extension NSAttributedString {
    func toHTML() -> String? {
        // Replace newlines with <br> tags
        let htmlString = self.string.replacingOccurrences(of: "\n", with: "<br>")
        
        // Convert to HTML
        do {
            let htmlData = try htmlString.data(using: .utf8)
            return String(data: htmlData!, encoding: .utf8)
        } catch {
            return nil
        }
    }
}
