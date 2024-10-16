//
//  PostEditView.swift
//  AppComic
//
//  Created by cao duc tin  on 5/10/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostCellForManageView: View {
    @State var post:PostModel = PostModel(dict: [:])
    
    var onDelete:(()->())?
    var body: some View {
        HStack(alignment:.top){
            WebImage(url: URL(string: post.image)) { image in
                   image.resizable()
                    .scaledToFill()
                    .frame(width: 140,height: 100)
                    .clipShape(
                        
                        RoundedRectangle(cornerRadius: 10)                                )
               } placeholder: {
                   
                       Rectangle().foregroundColor(.gray)
                       .frame(width: 140,height: 100)
               }
               // Supports options and context, like `.delayPlaceholder` to show placeholder only when error

               .transition(.fade(duration: 0.5)) // Fade Transition with duration
  
 
            VStack{
                Text(post.title)
                    .font(.system(size: 16, weight: .bold, design: .default))

                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
            
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(minWidth: 0,maxWidth: 200,alignment: .leading)
                  
                Spacer()
                HStack{
                    Text("\(post.createAt.toFormattedDateString()!)")

                    NavigationLink(destination: CreatePost(postToEdit: post)) {
                                    Text("Edit")
                            .foregroundStyle(.blue)
                                }
                    
                    Button {
                        onDelete?()
                    } label: {
                        Text("Delete")
                    }


                }
                .frame(minWidth: 0,maxWidth: 200,alignment: .leading)
              
            }
            .frame(height: 100)
           
        }
    }
    
}

#Preview {
    PostCellForManageView(post: PostModel(dict: ["_id": "66fe2d966d3758f3d37f7fc6",
                                                 "userId": "66f2db79606c6f21af9ee810",
                                                 "content": "<p>Học sinh tiểu học và THCS của Trung Quốc sẽ có ít nhất hai giờ hoạt động thể chất mỗi ngày, nhằm tăng cường sức khỏe.</p><p>Ông Wang Jia Yi, Thứ trưởng Bộ Giáo dục, phát biểu như trên tại một cuộc họp báo cách đây vài hôm. Cụ thể, mỗi ngày, học sinh sẽ tham gia một lớp thể thao và một giờ tập thể dục, sau giờ học.</p><p>Ông cho biết việc này nhằm giải quyết các vấn đề sức khỏe thường gặp của học sinh về mắt và cân nặng, bằng cách cho các em tiếp xúc đủ với ánh nắng mặt trời.</p><p>Tại Bắc Kinh, thời gian nghỉ 10 phút giữa các tiết học đã được kéo dài thành 15 phút, bắt đầu từ học kỳ mùa thu năm nay. Cơ quan giáo dục thành phố nói muốn giáo viên và học sinh đủ thời gian nghỉ giải lao, đồng thời khuyến khích học sinh dành thời gian ở ngoài trời để tăng cường sức khỏe thể chất và tinh thần.</p><p>Giáo dục thể chất ngày càng được quan tâm ở Trung Quốc. Học sinh không vượt qua bài kiểm tra thể dục sẽ không đạt danh hiệu học sinh giỏi.</p><p>Bài thi thể dục thường bao gồm nhảy dây một phút, chạy ngắn 50 m, gập bụng, bài gập người đo độ dẻo và chạy dài 800 m hoặc 1.000 m. Ngoài ra, học sinh được đo dung tích sống và chỉ số khối cơ thể (BMI) như một chỉ số đánh giá thể lực.</p><p>Cách đây vài năm, Quốc vụ viện nước này yêu cầu gia tăng tỷ trọng điểm của môn giáo dục thể chất trong kỳ thi vào trung học phổ thông. Ở Thâm Quyến, điểm tối đa cho môn giáo dục thể chất tăng từ 30 lên 50, so với 120 điểm ở môn tiếng Trung, 100 điểm với Toán, tiếng Anh. Tỉnh Vân Nam thậm chí còn tăng điểm giáo dục thể chất lên 100.</p><p><br></p>",
                                                 "title": "Trung Quốc đảm bảo hai giờ thể chất cho học sinh mỗi ngày",
                                                 "image": "https://firebasestorage.googleapis.com/v0/b/appcomic-3dbe4.appspot.com/o/1727933843421-giaoduc1.jpg?alt=media&token=ec5a6b4f-ab1d-42ae-85c3-abc411b81d66",
                                                 "category": "Giáo dục",
                                                 "slug": "trung-quc-m-bo-hai-gi-th-cht-cho-hc-sinh-mi-ngy",
                                                 "createdAt": "2024-10-03T05:37:26.095Z",
                                                 "updatedAt": "2024-10-03T05:37:26.095Z",
                                                 "__v": 0]))
}
