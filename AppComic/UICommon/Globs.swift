//
//  Globs.swift
//  AppComic
//
//  Created by cao duc tin  on 5/10/24.
//

import SwiftUI

struct Globs{
    
    static let BASE_URL = "http://localhost:3000/api/"
    
    static let Login_URL = BASE_URL + "auth/signin"
    
    static let SignUp_URL = BASE_URL + "auth/signup"
    
    static let GetPost_URL = BASE_URL + "post/getposts"
    
    static let GetComment_URL = BASE_URL + "comment/getPostComments/"
    
}
