//
//  PostDisplay.swift
//  AppComic
//
//  Created by cao duc tin  on 27/9/24.
//

import SwiftUI

struct PostDisplay: View {
    @State var post: PostModel = PostModel(dict: [:])
    var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                
                AsyncImage(url: URL(string: post.image)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(maxWidth:.screenWidth)
                        .clipShape(RoundedRectangle(cornerRadius: 10)) 
                       
                    
                } placeholder: {
                    ProgressView()
                }
                HStack{
                    Text(post.category)
                        .font(.system(size: 17, weight: .regular, design: .default))
                        .foregroundStyle(.gray)
                    Text("|")
                        .foregroundStyle(.gray)
                    Text(post.createAt.elapsedTimeString() ?? "1")
                        .font(.system(size: 17, weight: .regular, design: .default))
                        .foregroundStyle(.gray)
                    
                }
                
                Text(post.title)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .foregroundStyle(Color.black)
                
                HStack{
                    Text("0")
                    Image(systemName: "hand.thumbsup")
                    Image(systemName:"circlebadge.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 5)
                    Text("1")
                    Image(systemName: "message")
                }
                
                
                
                Divider()
            }
            .padding()
        
    }
}

#Preview {
    PostDisplay(post: PostModel(dict: ["_id": "66f630eba86c6bd5bef81e48",
                                       "userId": "66f18b872c50f92086b94a3d",
                                       "content": "<p><strong style=\"color: rgb(51, 51, 51);\">Ngày 25/9, Văn phòng Cơ quan CSĐT Công an tỉnh Đắk Nông vừa quyết định khởi tố vụ án, khởi tố bị can và lệnh khám xét chỗ ở, lệnh cấm đi khỏi nơi cư trú đối với Đỗ Thị Thuý (SN 1974, trú tại&nbsp;phường Nghĩa Thành, TP Gia Nghĩa, tỉnh Đắk Nông) về tội “Trốn thuế”. Các quyết định tố tụng trên đã được VKSND cùng cấp phê chuẩn.</strong></p><p class=\"ql-align-justify\"><span class=\"ql-cursor\">﻿</span><span style=\"background-color: initial;\">Theo điều tra ban đầu, năm 2021, trong quá trình mua bán nhận chuyển nhượng và chuyển nhượng quyền sử dụng đất trên địa bàn huyện Đắk Song và TP Gia Nghĩa, Đỗ Thị Thuý đã kê khai giá trị trên hợp đồng chuyển nhượng thấp hơn giá trị thực tế chuyển nhượng nhằm trốn tránh nghĩa vụ đóng thuế, phí cho nhà nước. Do đó, đã gây thất thoát tiền thuế, phí của Nhà nước.</span></p><p class=\"ql-align-justify\">Cụ thể, Thúy nhận chuyển nhượng quyền sử dụng 1 thửa đất tại tổ dân phố 7 (phường Nghĩa Thành, TP Gia Nghĩa), với giá trị chuyển nhượng thực tế là 9<em style=\"background-color: initial;\">&nbsp;</em>tỉ đồng. Tuy nhiên, Thúy đã kê khai giá trị trong hợp đồng chuyển nhượng số tiền 440 triệu đồng, thấp hơn giá chuyển nhượng thực tế nhằm trốn tránh nghĩa vụ đóng thuế, gây thất thoát cho nhà nước số tiền thuế&nbsp;là 166.635.000 đồng.</p><p class=\"ql-align-justify\">Tương tự, trong quá trình chuyển nhượng quyền sử dụng 4 thửa đất tại xã Nâm N’Jang (huyện Đắk Song, tỉnh Đắk Nông) giá trị chuyển nhượng thực tế là 6,93 tỉ đồng nhưng Thúy đã kê khai giá trị chuyển nhượng số tiền 400 triệu đồng, thấp hơn giá chuyển nhượng thực tế. Từ đó, gây thất thoát cho nhà nước số tiền 119.526.178 đồng...</p><p class=\"ql-align-justify\">Hiện vụ án đang được Cơ quan CSĐT Công an tỉnh Đắk Nông tiếp tục điều tra mở rộng để xử lý theo quy định của pháp luật./.</p><p><br></p>",
                                       "title": "Một phụ nữ bị khởi tố vì mua đất 9 tỉ nhưng làm hợp đồng 440 triệu đồng",
                                       "image": "https://www.hostinger.com/tutorials/wp-content/uploads/sites/2/2021/09/how-to-write-a-blog-post.png",
                                       "category": "pháp luật",
                                       "slug": "mt-ph-n-b-khi-t-v-mua-t-9-t-nhng-lm-hp-ng-440-triu-ng",
                                       "createdAt": "2024-09-27T04:13:31.559Z",
                                       "updatedAt": "2024-09-27T04:13:31.559Z",
                                       "__v": 0]))
}
