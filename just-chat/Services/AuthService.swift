import Foundation
import Firebase
import FirebaseAuth

struct AuthService {
    static let `default` = AuthService()
    
    private var auth = Auth.auth()
    
    private init () {}
    
    func signUp(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        auth.createUser(withEmail: email, password: password, completion: completion)
    }
    
    func signIn(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        auth.signIn(withEmail: email, password: password, completion: completion)
    }
    
    func signOut(completion: (Error?) -> Void) {
        do {
            try auth.signOut()
        } catch let error {
            completion(error)
        }
    }
}
