import Foundation

struct AppUser: Identifiable, Codable {
    var id: String
    var email: String
    
    init(id: String, email: String) {
        self.id = id
        self.email = email
    }
}
