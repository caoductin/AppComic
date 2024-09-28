//
//  CommentModel.swift
//  AppComic
//
//  Created by cao duc tin  on 28/9/24.
//

import SwiftUI

struct CommentModel:Identifiable,Equatable{
    var id: String 
    var content: String
    var postId: String
    var userId: String
    var likes: Array<String>
    var numberOfLikes: Int
    var createdAt: String
    var updatedAt: String
    init(dict: NSDictionary){
        self.id = dict.value(forKey: "_id") as? String ?? ""
        self.userId = dict.value(forKey: "userId") as? String ?? ""
        self.content = dict.value(forKey: "content") as? String ?? ""
        self.postId = dict.value(forKey: "postId") as? String ?? ""
        self.likes = (dict.value(forKey: "likes") as? Array<String>) ?? []
        self.createdAt = dict.value(forKey: "createdAt") as? String ?? ""
        self.updatedAt = dict.value(forKey: "updatedAt") as? String ?? ""
        self.numberOfLikes = dict.value(forKey: "numberOfLikes") as? Int ?? 0
    }

    
}

//{
//    "_id": "66f63164a86c6bd5bef81e74",
//    "content": "ăn nhiều quá\n",
//    "postId": "66f630eba86c6bd5bef81e48",
//    "userId": "66f18b872c50f92086b94a3d",
//    "likes": [],
//    "numberOfLikes": 0,
//    "createdAt": "2024-09-27T04:15:32.386Z",
//    "updatedAt": "2024-09-27T04:15:32.386Z",
//    "__v": 0
//},
