
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
    @Environment(\.modelContext) private var modelContext
    
    init() {
        self.getPost()
        
    }
   

    
    
    func getPost() {
        isLoading = true
        errorMessage = ""
        
        let parameters: [String: Any] = [:]
        
        ServiceCall.getComment(parameter: parameters, path: "http://localhost:3000/api/post/getposts", isToken: false, withSuccess: { response in
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

}
