//
//  PasswordStrengthUtility.swift
//  AppComic
//
//  Created by cao duc tin  on 25/9/24.
//

import SwiftUI

import SwiftUI

struct PasswordStrengthUtility {
    static func calculateStrength(for password: String) -> Int {
        var strengthScore = 0
        
        // Add points based on criteria
        if password.count >= 8 { strengthScore += 1 }
        if password.range(of: "[A-Z]", options: .regularExpression) != nil { strengthScore += 1 }
        if password.range(of: "[0-9]", options: .regularExpression) != nil { strengthScore += 1 }
        if password.range(of: "[^a-zA-Z0-9]", options: .regularExpression) != nil { strengthScore += 1 }
        
        // Return a score between 0 and 4
        return strengthScore
    }
    
    static func strengthColor(for strength: Int) -> Color {
        switch strength {
        case 4: return .green
        case 3: return .yellow
        case 2: return .orange
        case 1: return .red
        default: return .gray
        }
    }
}
