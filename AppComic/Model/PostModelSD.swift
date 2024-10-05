//
//  PostModelSD.swift
//  AppComic
//
//  Created by cao duc tin  on 30/9/24.
//

import SwiftUI
import SwiftData

@Model
class PostModelSD {
    @Attribute(.unique) var id: String
    var userID: String
    var content:String
    var title: String
    var image: String
    var category: String
    var slug: String
    var createAt: String
    var updateAt: String
    init(dict: NSDictionary) {
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
    // Static method to create mock data
    
       static func mockData() -> [PostModelSD] {
           let mockPosts = [
               [
                "_id": "66f6a889a86c6bd5bef8214a",
                            "userId": "66f2db79606c6f21af9ee810",
                            "content": "<h2><strong>Lewandowski và Xavi có mâu thuẫn lớn trước khi mất ghế vào tay HLV Hansi Flick, người đang có những thay đổi mạnh mẽ, ấn tượng ở Barca.</strong></h2><p>Diario Sport cho hay, Xavi đã&nbsp;<em>“phản bội”</em>&nbsp;<a href=\"https://vietnamnet.vn/robert-lewandowski-tag16577347092513972446.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(45, 103, 173);\"><strong>Robert Lewandowski</strong></a>, lúc còn tại vị trên ‘ghế nóng’ Barca, khi đề nghị CLB đẩy tiền đạo này đi chỉ sau 2 năm.</p><p>Cụ thể, vị thuyền trưởng đã nói với lãnh đạo&nbsp;<a href=\"https://vietnamnet.vn/barcelona-tag15651866867909596045.html\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(45, 103, 173);\"><strong>Barca</strong></a>&nbsp;rằng, Lewandowski đã luống tuổi, không còn đảm bảo thể lực để dẫn dắt hàng công của đội nên cần thay bằng một tiền đạo khác, trẻ khỏe hơn.</p><p><br></p><p>Chuyện đến tai Lewandowski và anh đã rất tức giận, bởi trước đó là một trong những người đã cố thuyết phục Xavi ở lại. Mối quan hệ giữa họ căng thẳng và tệ đi từ đó cho đến cựu tiền vệ Barca bị CLB sa thải.</p><p>Xavi từng tuyên bố rời Barca vào đầu năm nay, bởi kết quả không như ý của đội. Dù vậy, vị thuyền trưởng đã thay đổi ý định sau cuộc gặp với Chủ tịch Joan Laporta, cùng với việc đội chơi ngày một tốt lên.</p><p>Nhưng sau đó, Xavi lại không thể ‘giữ ghế’, bị sa thải bởi chính người đã thuyết phục ông ở lại, sau những phát biểu được cho gây tức giận với lãnh đạo CLB.</p><p>Vào mùa hè, Hansi Flick đã đến thay Xavi và có những thay đổi mạnh mẽ ở Barca, với chuỗi 7 trận toàn thắng từ đầu mùa La Liga 2024/25 đến nay, ghi 23 bàn và chỉ để thủng lưới 5 bàn.</p><p>Bản thân Robert Lewandowski cũng cho thấy, Xavi đã sai bởi anh đang có phong độ rất tốt, ghi 7 bàn và 2 kiến tạo ở La Liga mùa này.</p><p><br></p><p><br></p>",
                            "title": "Lộ mâu thuẫn Lewandowski và Xavi trước khi mất ghế vào Hansi Flick",
                            "image": "https://firebasestorage.googleapis.com/v0/b/appcomic-3dbe4.appspot.com/o/1727441029714-baibaopl.jpg?alt=media&token=e69e37cb-eda8-42d9-be4e-b3764da9499d",
                            "category": "thể thao",
                            "slug": "l-mu-thun-lewandowski-v-xavi-trc-khi-mt-gh-vo-hansi-flick",
                            "createdAt": "2024-09-27T12:43:53.011Z",
                            "updatedAt": "2024-09-27T12:43:53.011Z",
                            "__v": 0
               ],
               [
                "_id": "66f630eba86c6bd5bef81e48",
                            "userId": "66f18b872c50f92086b94a3d",
                            "content": "<p><strong style=\"color: rgb(51, 51, 51);\">Ngày 25/9, Văn phòng Cơ quan CSĐT Công an tỉnh Đắk Nông vừa quyết định khởi tố vụ án, khởi tố bị can và lệnh khám xét chỗ ở, lệnh cấm đi khỏi nơi cư trú đối với Đỗ Thị Thuý (SN 1974, trú tại&nbsp;phường Nghĩa Thành, TP Gia Nghĩa, tỉnh Đắk Nông) về tội “Trốn thuế”. Các quyết định tố tụng trên đã được VKSND cùng cấp phê chuẩn.</strong></p><p class=\"ql-align-justify\"><span class=\"ql-cursor\">﻿</span><span style=\"background-color: initial;\">Theo điều tra ban đầu, năm 2021, trong quá trình mua bán nhận chuyển nhượng và chuyển nhượng quyền sử dụng đất trên địa bàn huyện Đắk Song và TP Gia Nghĩa, Đỗ Thị Thuý đã kê khai giá trị trên hợp đồng chuyển nhượng thấp hơn giá trị thực tế chuyển nhượng nhằm trốn tránh nghĩa vụ đóng thuế, phí cho nhà nước. Do đó, đã gây thất thoát tiền thuế, phí của Nhà nước.</span></p><p class=\"ql-align-justify\">Cụ thể, Thúy nhận chuyển nhượng quyền sử dụng 1 thửa đất tại tổ dân phố 7 (phường Nghĩa Thành, TP Gia Nghĩa), với giá trị chuyển nhượng thực tế là 9<em style=\"background-color: initial;\">&nbsp;</em>tỉ đồng. Tuy nhiên, Thúy đã kê khai giá trị trong hợp đồng chuyển nhượng số tiền 440 triệu đồng, thấp hơn giá chuyển nhượng thực tế nhằm trốn tránh nghĩa vụ đóng thuế, gây thất thoát cho nhà nước số tiền thuế&nbsp;là 166.635.000 đồng.</p><p class=\"ql-align-justify\">Tương tự, trong quá trình chuyển nhượng quyền sử dụng 4 thửa đất tại xã Nâm N’Jang (huyện Đắk Song, tỉnh Đắk Nông) giá trị chuyển nhượng thực tế là 6,93 tỉ đồng nhưng Thúy đã kê khai giá trị chuyển nhượng số tiền 400 triệu đồng, thấp hơn giá chuyển nhượng thực tế. Từ đó, gây thất thoát cho nhà nước số tiền 119.526.178 đồng...</p><p class=\"ql-align-justify\">Hiện vụ án đang được Cơ quan CSĐT Công an tỉnh Đắk Nông tiếp tục điều tra mở rộng để xử lý theo quy định của pháp luật./.</p><p><br></p>",
                            "title": "Một phụ nữ bị khởi tố vì mua đất 9 tỉ nhưng làm hợp đồng 440 triệu đồng",
                            "image": "https://www.hostinger.com/tutorials/wp-content/uploads/sites/2/2021/09/how-to-write-a-blog-post.png",
                            "category": "pháp luật",
                            "slug": "mt-ph-n-b-khi-t-v-mua-t-9-t-nhng-lm-hp-ng-440-triu-ng",
                            "createdAt": "2024-09-27T04:13:31.559Z",
                            "updatedAt": "2024-09-27T04:13:31.559Z",
                            "__v": 0
               ]
           ]

           return mockPosts.map { PostModelSD(dict: $0 as NSDictionary) }
       }
    }
