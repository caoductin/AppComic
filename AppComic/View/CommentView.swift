//
//  CommentView.swift
//  AppComic
//
//  Created by cao duc tin  on 29/9/24.
//

import SwiftUI

struct CommentView: View {
    @ObservedObject var commentVM: CommentViewModel = CommentViewModel(postID: "66f630eba86c6bd5bef81e48")
    var body: some View {
        VStack{
            Button(action: {
                commentVM.printcommmet()
                print(commentVM.commment.count)
            }, label: {
                Text("Button")
            })
            Text("\(commentVM.commment.count)")
       
                              ForEach(commentVM.commment, id: \.id) { comment in
                                  Text(comment.content)
                              }
                
                          
            
        }
    }
}

#Preview {
    CommentView()
}
