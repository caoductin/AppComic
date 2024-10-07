//
//  UserCommentCell.swift
//  AppComic
//
//  Created by cao duc tin  on 28/9/24.
//

import SwiftUI
import SDWebImageSwiftUI
struct UserCommentCell: View {
    @Binding var comment: CommentModel // Change to @Binding
//    @StateObject var userModel:UserViewModel = UserViewModel(userId: "66f3c539606c6f21af9ee86e")
    @State var userModel: UserModel
    var actionForLike: (() -> Void)?
    var actionForDelete: (() -> Void)?
    var actionForEdit: (() -> Void)?
    
    @State var islike: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                WebImage(url: URL(string: userModel.profilePicture)) { image in
                       image.resizable()
                        .scaledToFill()
                        .frame(width:40,height: 40)
                        .clipShape(
                            
                           Circle()                              )
                   } placeholder: {
                           Rectangle().foregroundColor(.gray)
                   }
                   // Supports options and context, like `.delayPlaceholder` to show placeholder only when error

                   .transition(.fade(duration: 0.5)) // Fade Transition
               
                Text(userModel.userName) // You may want to replace this with a dynamic user name
                Spacer()
                Text(comment.createdAt.elapsedTimeString() ?? "undefined time")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            VStack {
                Text(comment.content)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                HStack {
                    Button(action: {
                        actionForLike?()
                        islike.toggle()
                    }, label: {
                        Image(systemName: islike ? "hand.thumbsup.fill" : "hand.thumbsup")
                    })
                    Text("\(comment.likes.count) likes")
                    Spacer()
                    Button(action: {
                        actionForDelete?() // Call delete action
                    }, label: {
                        Text("Delete")
                    })
                    
                    Button(action: {
                        actionForEdit?() // Call edit action
                    }, label: {
                        Text("Edit")
                    })
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 50)
            
            Divider()
        }
        .onAppear(perform: {
            checkLike()
        })
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 10)
    }
    func checkLike(){
        if  comment.likes.contains(where: { like in
            like == userModel.id
        }){
            islike = true
        }
        else{
            islike = false
        }
        
    }
        
}

#Preview {
    @State var isLike = false
    
    return UserCommentCell(comment: .constant(CommentModel(dict: ["_id": "66f63164a86c6bd5bef81e74",
                                                         "content": "ăn nhiều quá\n",
                                                         "postId": "66f630eba86c6bd5bef81e48",
                                                         "userId": "66f18b872c50f92086b94a3d",
                                                         "likes": [],
                                                         "numberOfLikes": 0,
                                                         "createdAt": "2024-09-27T04:15:32.386Z",
                                                         "updatedAt": "2024-09-27T04:15:32.386Z",
                                                           "__v": 0])), userModel: UserModel(dict: [    "_id": "66f3c539606c6f21af9ee86e",
                                                                                                        "username": "cao duc ti",
                                                                                                        "email": "tin2@gmail.com",
                                                                                                        "profilePicture": "https://firebasestorage.googleapis.com/v0/b/appcomic-3dbe4.appspot.com/o/1728038971007phapluat2.jpg?alt=media&token=b2e63d3a-4e06-4c13-af1d-2e29fddd570a",
                                                                                                        "isAdmin": false,
                                                                                                        "createdAt": "2024-09-25T08:09:29.734Z",
                                                                                                        "updatedAt": "2024-10-04T10:49:39.830Z",
                                                                                                        "__v": 0]))
}
