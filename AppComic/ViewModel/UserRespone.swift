//
//  UserRespone.swift
//  AppComic
//
//  Created by cao duc tin  on 24/9/24.
//

import SwiftUI

import Foundation

struct UserResponse: Codable {
    var id: String
    var userName: String
    var email: String
    var profilePicture: String
    var isAdmin: Bool
    var updatedAt: String  // Use String or Date based on API format
    var createdAt: String  // Use String or Date based on API format
}
