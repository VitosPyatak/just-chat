import Foundation

struct AppUser: Identifiable, Codable {
    var id: String
    var email: String
    var imageUrl: String
    
    init(id: String, email: String, imageUrl: String) {
        self.id = id
        self.email = email
        self.imageUrl = imageUrl
    }
}
