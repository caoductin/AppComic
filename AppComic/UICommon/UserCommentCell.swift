//
//  UserCommentCell.swift
//  AppComic
//
//  Created by cao duc tin  on 28/9/24.
//

import SwiftUI

struct UserCommentCell: View {
    @State var comment: CommentModel = CommentModel(dict: [:])
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.gray.opacity(0.4))
                    .frame(width: 40)
                Text("cao duc tin")
                Spacer()
                Text(comment.updatedAt.elapsedTimeString() ?? "undified time")
            }
            .frame(width: .infinity,alignment: .leading)
            VStack {
                Text(comment.content)
                    .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
                HStack{
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "hand.thumbsup")
                        
                    })
                    Text("\(comment.likes.count) likes")
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Text("Delete")
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Edit")
                    })
                    
                }
             
            }
       
            .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
            .padding(.leading,50)
            
            Divider()
            
            
        }
        .frame(maxWidth: .screenWidth,alignment: .leading)
        .padding(.horizontal,10)
      
    }
}

#Preview {
    UserCommentCell(comment: CommentModel(dict: ["_id": "66f63164a86c6bd5bef81e74",
                                                 "content": "ăn nhiều quá\n",
                                                 "postId": "66f630eba86c6bd5bef81e48",
                                                 "userId": "66f18b872c50f92086b94a3d",
                                                 "likes": [],
                                                 "numberOfLikes": 0,
                                                 "createdAt": "2024-09-27T04:15:32.386Z",
                                                 "updatedAt": "2024-09-27T04:15:32.386Z",
                                                 "__v": 0]))
}
