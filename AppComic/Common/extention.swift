//
//  extention.swift
//  AppComic
//
//  Created by cao duc tin  on 27/9/24.
//

import SwiftUI

import Foundation
import SwiftUI
import UIKit


extension CGFloat {
    
    static var screenWidth: Double {
        return UIScreen.main.bounds.size.width
    }
    
    static var screenHeight: Double {
        return UIScreen.main.bounds.size.height
    }
    
    static func widthPer(per: Double) -> Double {
        return screenWidth * per
    }
    
    static func heightPer(per: Double) -> Double {
        return screenHeight * per
    }
    
    static var currentKeyWindow: UIWindow? {
          return UIApplication.shared
              .connectedScenes
              .filter { $0.activationState == .foregroundActive }
              .compactMap { $0 as? UIWindowScene }
              .first?.windows
              .first { $0.isKeyWindow }
      }
      
      // Top inset
      static var topInsets: Double {
          return Double(currentKeyWindow?.safeAreaInsets.top ?? 0.0)
      }
      
      // Bottom inset0
      static var bottomInsets: Double {
          return Double(currentKeyWindow?.safeAreaInsets.bottom ?? 0.0)
      }
      
      // Horizontal insets (left + right)
      static var horizontalInsets: Double {
          guard let safeAreaInsets = currentKeyWindow?.safeAreaInsets else { return 0.0 }
          return safeAreaInsets.left + safeAreaInsets.right
      }
      
      // Vertical insets (top + bottom)
      static var verticalInsets: Double {
          guard let safeAreaInsets = currentKeyWindow?.safeAreaInsets else { return 0.0 }
          return safeAreaInsets.top + safeAreaInsets.bottom
      }
    
}

extension String {
    func htmlToAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil
            )
        } catch {
            print("Error converting HTML to AttributedString:", error)
            return nil
        }
    }

    func htmlToString() -> Text {
        guard let attrString = htmlToAttributedString() else {
            return Text(self) // Fallback to plain text if conversion fails
        }

        var resultText = Text("")
        
        attrString.enumerateAttributes(in: NSRange(location: 0, length: attrString.length), options: []) { attributes, range, _ in
            let substring = (attrString.string as NSString).substring(with: range)

            var textSegment = Text(substring)

            if let font = attributes[.font] as? UIFont {
                let isBold = font.fontDescriptor.symbolicTraits.contains(.traitBold)
                textSegment = isBold ? textSegment.bold() : textSegment
            }

            if let foregroundColor = attributes[.foregroundColor] as? UIColor {
                textSegment = textSegment.foregroundColor(Color(foregroundColor))
            }

            resultText = resultText + textSegment
        }

        return resultText
    }
}

extension String {
    func elapsedTimeString() -> String? {
        // Create a date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // Adjusting to match your format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        // Try to convert the ISO 8601 string to a Date
        guard let date = dateFormatter.date(from: self) else {
            return nil // Return nil if the date is invalid
        }
        
        // Calculate the time interval from the date to now
        let timeInterval = Date().timeIntervalSince(date)
        let elapsedSeconds = Int(timeInterval)
        
        // Return in seconds, minutes, or hours if within 24 hours
        if elapsedSeconds < 60 {
            return "\(elapsedSeconds) seconds ago"
        } else if elapsedSeconds < 3600 {
            let minutes = elapsedSeconds / 60
            return "\(minutes) minutes ago"
        } else if elapsedSeconds < 86400 { // 24 * 60 * 60 = 86400 seconds in 24 hours
            let hours = elapsedSeconds / 3600
            return "\(hours) hours ago"
        }
        
        // If more than 24 hours but less than 10 days, return formatted date
        let days = elapsedSeconds / 86400
        if days <= 10 {
            // Customize how you want to display the date for times greater than 24 hours and less than 10 days
            let dateFormatterForDisplay = DateFormatter()
            dateFormatterForDisplay.dateStyle = .medium // You can customize this
            dateFormatterForDisplay.timeStyle = .none
            return dateFormatterForDisplay.string(from: date)
        }
        
        // If more than 10 days, return full date
        let dateFormatterForFullDate = DateFormatter()
        dateFormatterForFullDate.dateFormat = "MMM dd, yyyy" // Custom date format for more than 10 days
        return dateFormatterForFullDate.string(from: date)
    }
}
