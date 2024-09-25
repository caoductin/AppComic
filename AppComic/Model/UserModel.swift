//
//  UserModel.swift
//  AppComic
//
//  Created by cao duc tin  on 24/9/24.
//

import SwiftUI

class UserModel: Identifiable,Equatable{
    var id: String
    var userName: String
    var email: String
    var password: String
    var profilePicture: String
    var isAdmin: Bool
    var updateAt: String
    var createAt: String
    init(dict: Dictionary<String, Any>) {
        self.id = dict["id"] as? String ?? ""
               self.userName = dict["userName"] as? String ?? ""
               self.email = dict["email"] as? String ?? ""
               self.profilePicture = dict["profilePicture"] as? String ?? ""
               self.isAdmin = dict["isAdmin"] as? Bool ?? false
               self.updateAt = dict["updatedAt"] as? String ?? ""
                self.createAt = dict["createdAt"] as? String ?? ""
                self.password = dict["password"] as? String ?? ""
    }
        static func == (lhs: UserModel, rhs: UserModel) -> Bool {
            return lhs.id == rhs.id
        }
}


//{
//    "_id": "66f18b872c50f92086b94a3d",
//    "username": "tin",
//    "email": "tin@gmail.com",
//    "profilePicture": "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
//    "isAdmin": false,
//    "createdAt": "2024-09-23T15:38:47.142Z",
//    "updatedAt": "2024-09-23T15:38:47.142Z",
//    "__v": 0
//}
