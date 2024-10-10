import SwiftUI
import FirebaseStorage

class ImagePickerViewModel: ObservableObject {
    @Published var selectedImage: UIImage? = nil
    @Published var uploadStatus: String = "No image uploaded yet"
    @Published var imageURL: URL? = nil
    @Published var uploadProgress: Double = 0.0  // Progress percentage

    // Function to upload image to Firebase and get the URL
    func uploadImageToFirebase() {
        guard let image = selectedImage else {
            uploadStatus = "No image selected"
            return
        }

        let storage = Storage.storage()
        let storageRef = storage.reference().child("images/\(UUID().uuidString).jpg")

        // Convert UIImage to JPEG Data
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            uploadStatus = "Failed to convert image to data"
            return
        }

        // Upload the image data to Firebase with progress tracking
        let uploadTask = storageRef.putData(imageData, metadata: nil)

        // Observe upload progress
        uploadTask.observe(.progress) { snapshot in
            if let progress = snapshot.progress {
                let percentage = Double(progress.completedUnitCount) / Double(progress.totalUnitCount)
                DispatchQueue.main.async {
                    self.uploadProgress = percentage
                }
            }
        }

        // Handle completion and URL retrieval
        uploadTask.observe(.success) { _ in
            storageRef.downloadURL { url, error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.uploadStatus = "Failed to get image URL: \(error.localizedDescription)"
                    }
                    return
                }

                if let downloadURL = url {
                    DispatchQueue.main.async {
                        self.uploadStatus = "Image uploaded successfully"
                        self.imageURL = downloadURL // Store the image URL
                    }
                }
            }
        }

        // Handle failure
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error {
                DispatchQueue.main.async {
                    self.uploadStatus = "Failed to upload image: \(error.localizedDescription)"
                }
            }
        }
    }
}
