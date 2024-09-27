//
//  PostModel.swift
//  AppComic
//
//  Created by cao duc tin  on 26/9/24.
//

import SwiftUI

struct PostModel: Identifiable,Equatable{
    var id: String
    var userID: String
    var content:String
    var title: String
    var image: String
    var category: String
    var slug: String
    var createAt: String
    var updateAt: String
    
    
    init(dict: Dictionary<String, Any>) {
        self.id = dict["_id"] as? String ?? ""
        self.userID = dict["userId"] as? String ?? ""
        self.content = dict["content"] as? String ?? ""
        self.title = dict["title"] as? String ?? ""
        self.updateAt = dict["updatedAt"] as? String ?? ""
        self.createAt = dict["createdAt"] as? String ?? ""
        self.category = dict["category"] as? String ?? ""
        self.slug = dict["slug"] as? String ?? ""
        self.image = dict["image"] as? String ?? ""
    }
    
    static func == (lhs: PostModel, rhs: PostModel) -> Bool {
        return lhs.id == rhs.id
    }
}

//{
//    "status": "success",
//    "message": "Posts retrieved successfully",
//    "payload": {
//        "posts": [
//            {
//                "_id": "66f39063606c6f21af9ee84a",
//                "userId": "66f18b872c50f92086b94a3d",
//                "content": "ong haong gia kim",
//                "title": "test online",
//                "image": "https://www.hostinger.com/tutorials/wp-content/uploads/sites/2/2021/09/how-to-write-a-blog-post.png",
//                "category": "uncategorized",
//                "slug": "test-online",
//                "createdAt": "2024-09-25T04:24:03.691Z",
//                "updatedAt": "2024-09-25T04:24:03.691Z",
//                "__v": 0
//            }
//        ],
//        "totalPosts": 1,
//        "lastMonthPosts": 1
//    }
//}
