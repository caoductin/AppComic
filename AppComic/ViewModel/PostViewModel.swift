
import SwiftUI
import SwiftData

class PostViewModel: ObservableObject {
    static var shared: PostViewModel = PostViewModel()
    
    @Published var postModel: [PostModel] = []
    @Published var txtuserName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var user: UserModel?
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    //for create post
    @Published var title : String = ""
    @Published var image: String? = ""
    @Published var content: String = ""
    @Published var category : String? = ""
    //for html Content
    @Published var htmlContent: String = ""
    
    private var userId: String = ""
    @Environment(\.modelContext) private var modelContext
    
    init() {
        self.getPost()
        
    }
    init(test: String){
        
    }
  
//    init(postId: String){
//        self.deletePost(postId: postId,context: ModelContext)
//    }
    func removePost(byId id: String) {
        if let index = self.postModel.firstIndex(where: { $0.id == id  }) {
            self.postModel.remove(at: index)
        } else {
            print("Post with id \(id) not found.")
        }
    }

    func deletePost(postId: String){
        isLoading = true
        errorMessage = ""
        //get userId
        print("delete post is call")
        if let userId = UserDefaults.standard.string(forKey: "userId"){
            self.userId = userId
            print("userid\(self.userId)")
        }
        else{
            errorMessage = "the userId is not valid"
            print(errorMessage)
            isLoading = false
            return
        }

        let parameters: [String: Any] = [:]
        let path = "http://localhost:3000/api/post/deletepost/\(postId)/\(self.userId)"
        
        ServiceCall.delete(parameter: parameters, path: path, isToken: true, withSuccess: { response in
            // Handle success
            DispatchQueue.main.async {
                   self.isLoading = false
                   
                   // Handle success: Check for the success message
                   if let jsonResponse = response as? NSDictionary,
                      let message = jsonResponse["message"] as? String {
                       // Check if the response message indicates success
                       if message == "The post has been successfully deleted" {
                           // Deletion was successful
                           print("Delete success: \(message)")
                       
                               self.isLoading = true
                               self.removePost(byId: postId)
                           Swift.debugPrint("this is my post\(self.postModel)")
                    
                           self.errorMessage = "The post has been deleted successfully."
                       } else {
                           // Handle unexpected messages
                           self.errorMessage = message
                           print("\(self.errorMessage)")
                       }
                   } else {
                       // Handle fallback if the response is a plain string
                       self.errorMessage = response as? String ?? "Unknown success response"
                   }
                   
                   print("Final message: \(self.errorMessage)")
               }
            
        }, failure: { error in
        
            DispatchQueue.main.async {
                self.errorMessage = error?.localizedDescription ?? "Unknown error"
                print("this is error\(self.errorMessage)")
                self.isLoading = false
            }
        })
    }
    
        //create post for admin
    func CreatePost(){
        isLoading = true
        errorMessage = ""
        
        let parameters: [String: Any] = [
            "title": title,
            "category": category ?? "uncategory",
            "image": image ?? "",
            "content" : content
        ]
        let path = "http://localhost:3000/api/post/create"
        ServiceCall.post(parameter: parameters, path: path, isToken: true, withSuccess: { response in
            Swift.debugPrint("this is respone \(response)")
            if let responseDict = response as?  NSDictionary {
                // Assuming the response dictionary contains the newly created comment data
                Swift.debugPrint(responseDict)
                if let responseSuccess = responseDict["success"] as? Int{
                    DispatchQueue.main.async {
                        self.errorMessage = responseDict["message"] as? String ?? "Fail to Create"
                    print("respose Sucess")
         
                    }
                    return
                }

                self.postModel.append(PostModel(dict: responseDict as? Dictionary<String, Any> ?? [:]))
                DispatchQueue.main.async {
                    // Add the newly created comment to the comment list
                    Swift.debugPrint(self.postModel)

                }
              
            } else {
                print("Response is not valid")
            }
        }, failure: { error in
            DispatchQueue.main.async {
                print("Failed to create post")
                self.errorMessage = error?.localizedDescription ?? "Unknown error"
                self.isLoading = false
            }
        })
    }

    
    func getPost() {
        isLoading = true
        errorMessage = ""
        
        let parameters: [String: Any] = [:]
        
        ServiceCall.getComment(parameter: parameters, path: Globs.GetPost_URL, isToken: false, withSuccess: { response in
            // Handle success
            if let response = response as? [String: Any],
               let postsArray = response["posts"] as? [[String: Any]] {
                
                let postModels = postsArray.compactMap { PostModel(dict: $0) }
                self.postModel = postModels
                    self.isLoading = false
                
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Invalid response structure"
                    self.isLoading = false
                }
            }
        }, failure: { error in
            DispatchQueue.main.async {
                self.errorMessage = error?.localizedDescription ?? "Unknown error"
                self.isLoading = false
            }
        })
    }
    
    func savePostsToSwiftData(postModels: [PostModelSD]) {
        for postSD in postModels {
            modelContext.insert(postSD)
            print("Inserted Post: \(postSD.title)") // Add a print statement to verify
        }

        // Optionally, save the context to persist the data
        do {
            try modelContext.save()
            print("Data saved successfully.")
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
    
    
    
    


}
