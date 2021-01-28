import Foundation
import SwiftUI

import Firebase
import FirebaseAuth

class UserSession: ObservableObject {
    @Published var appUser: AppUser?
    
    private let authService = AuthService.default
        
    func signIn(email: String, password: String, completion complete: @escaping (AuthDataResult?, Error?) -> Void) {
        authService.signIn(email: email, password: password) { result, error in
            self.onAuthenticationCompletionHandler(result, error)
            complete(result, error)
        }
    }
    
    func singUp(email: String, password: String, completion complete: @escaping (AuthDataResult?, Error?) -> Void) {
        authService.signUp(email: email, password: password) { result, error in
            self.onAuthenticationCompletionHandler(result, error)
            complete(result, error)
        }
    }
    
    private func signOut(completion complete: @escaping (Error?) -> Void) {
        authService.signOut { error in
            onSignOutCompletionHandler(error: error)
            complete(error)
        }
    }
    
    private func onAuthenticationCompletionHandler(_ result: AuthDataResult?, _ error: Error?) {
        if let result = result {
            appUser = AppUser(id: result.user.uid, email: result.user.email!)
        } else {
            appUser = nil
        }
    }
    
    private func onSignOutCompletionHandler(error: Error?) {
        if error != nil {
            appUser = nil
        }
    }
}
