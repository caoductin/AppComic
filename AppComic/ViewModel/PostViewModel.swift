
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
    private var userId: String = ""
    @Environment(\.modelContext) private var modelContext
    
    init() {
        self.getPost()
        
    }
//    init(postId: String){
//        self.deletePost(postId: postId,context: ModelContext)
//    }
   
    func deletePost(postId: String,context: ModelContext){
        isLoading = true
        errorMessage = ""
        //get userId
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
                       if message == "Post deleted successfully" {
                           // Deletion was successful
                           print("Delete success: \(message)")
                           // Delete from SwiftData
                           self.deletePostFromSwiftData(postId: postId, context: context)
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
                    Swift.debugPrint(self.postModel)
                
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
    
    
    private func deletePostFromSwiftData(postId: String, context: ModelContext) {
        // Create a FetchDescriptor with the predicate to find the post by ID
               let descriptor = FetchDescriptor<PostModelSD>(
                   predicate: #Predicate { $0.id == postId }
               )

               // Fetch the post using the descriptor
               if let postToDelete = try? context.fetch(descriptor).first {
                   context.delete(postToDelete)
                   try? context.save()
               }
    }


}
