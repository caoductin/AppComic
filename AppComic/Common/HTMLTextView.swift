import SwiftUI
import UIKit

struct HTMLTextView: UIViewRepresentable {
    let htmlContent: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.backgroundColor = .clear
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if let data = htmlContent.data(using: .utf8) {
            do {
                let attributedString = try NSAttributedString(data: data,
                                                              options: [.documentType: NSAttributedString.DocumentType.html,
                                                                        .characterEncoding: String.Encoding.utf8.rawValue],
                                                              documentAttributes: nil)
                uiView.attributedText = attributedString
            } catch {
                uiView.text = "Failed to load content"
            }
        }
    }
}
