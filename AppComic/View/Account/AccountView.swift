//
//  AccountView.swift
//  AppComic
//
//  Created by cao duc tin  on 4/10/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct AccountView: View {
    @StateObject var AccountViewMD: LoginViewModel = LoginViewModel.shared
    @StateObject var PostVM =  PostViewModel.shared
    var body: some View {
        
        ZStack{
            VStack{
                WebImage(url: URL(string: AccountViewMD.user?.profilePicture ?? "https://firebasestorage.googleapis.com/v0/b/appcomic-3dbe4.appspot.com/o/1728038971007phapluat2.jpg?alt=media&token=b2e63d3a-4e06-4c13-af1d-2e29fddd570a")) { image in
                       image.resizable()
                        .scaledToFill()
                        .frame(width: 100,height: 80)
                        .clipShape(
                            
                            Circle()
                        )
                   } placeholder: {
                           Rectangle().foregroundColor(.gray)
                           .frame(width: 100,height: 80)
                   }
                   // Supports options and context, like `.delayPlaceholder` to show placeholder only when error

                   .transition(.fade(duration: 0.5)) // Fade
                Text("Cao Duc tin")
                    .font(.headline)
                Spacer()
                
                VStack(spacing: 10){
                    Divider()
                    NavigationLink {
                        CreatePost()
                    } label: {
                        CellAccountView(imageName: "person", title: "Profile User")
                    }
                    .foregroundStyle(.black)

                        
                    
                    Divider()
                        .frame(height: 1)
                    NavigationLink {
                        ManagePostView(PostViewMD:PostVM )
                    } label: {
                        CellAccountView(imageName: "magazine", title: "Posts")
                    }
                    .foregroundStyle(.black)
                   
         
                    Divider()
                        .frame(height: 1)
                    
                    CellAccountView(imageName: "person.badge.clock", title: "Users")
                   
                    Divider()
                        .frame(height: 1)
                        CellAccountView(imageName: "ellipsis.message", title: "Comment")
                
                    Divider()
                        .frame(height: 1)
                    CellAccountView(imageName: "square.and.arrow.down.on.square", title: "Saved posts")
                
                }
                .frame(maxWidth: .screenWidth/1.1)
                .background(
                   
                    RoundedRectangle(cornerRadius: 20)
                           .fill(Color.white) // Set the background color to white
                           .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 5)
                        
                )
                Spacer()
            }
            VStack{
                HStack{
                    Text("Account")
                        .font(.system(size: 19, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.leading,10)
                    VStack{
                        Button {
                            AccountViewMD.isLogin.toggle()
                        } label: {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .font(.system(size: 19,weight: .bold,design: .default))
                            Text("Log out")
                                .font(.system(size: 19,weight: .semibold))
                        }

                      
                    }
                    
                }
                Spacer()
               
                
            }
            
           
            
        }
        .frame(minWidth: 0,maxWidth: .infinity,minHeight: 0,maxHeight: .infinity)
        .background(Color.init(hex: "#E5E4E2"))
    }
}

#Preview {
    NavigationStack{
        AccountView()
    }
}
