import Foundation
import SwiftUI

import Firebase
import FirebaseAuth

class UserSession: ObservableObject {
    let defaults = UserDefaults.standard
    
    @Published var appUser: AppUser?
    @Published var seenOnboarding: Bool?
    @Published var userProfile: UserProfile?
    @Published var usernameErrorMessage: String?
    @Published var emailErrorMessage: String?
    @Published var passwordErrorMessage: String?
    @Published var confirmationErrorMessage: String?
    
    private let authService = AuthService.default
    
    init() {
        seenOnboarding = defaults.bool(forKey: UserDefaultsKeys.onboarding)
        userProfile = UserProfileService.getUserProfile()
    }
    
    func signIn(email: String, password: String, completion complete: @escaping (AuthDataResult?, Error?) -> Void) {
        authService.signIn(email: email, password: password) { result, error in
            self.onAuthenticationCompletionHandler(result, error)
            complete(result, error)
        }
    }
    
    func singUp(form: RegistrationViewModel, imageUrl: String, completion complete: @escaping (AuthDataResult?, Error?) -> Void) {
        authService.signUp(email: form.email.bound, password: form.email.bound) { result, error in
            if let result = result {
                self.saveUserProfile(username: form.username.bound, userId: result.user.uid, imageUrl: imageUrl)
            }
            self.onAuthenticationCompletionHandler(result, error)
            complete(result, error)
        }
    }
    
    private func saveUserProfile(username: String, userId: String, imageUrl: String) {
        let userProfile = UserProfile(username: username, imageUrl: imageUrl, userId: userId)
        UserProfileService.saveUserProfile(UserProfile(username: username, imageUrl: imageUrl, userId: userId))
        self.userProfile = userProfile
    }
    
    private func validateUserData(username: String, email: String, password: String, confirmation: String) -> Bool {
        usernameErrorMessage = ValidationService.validateUsername(username: username)
        emailErrorMessage = ValidationService.validateEmail(email: email)
        passwordErrorMessage = ValidationService.validatePassword(password: password)
        confirmationErrorMessage = ValidationService.validateConfirmation(password: password, confirmation: confirmation)
        
        return usernameErrorMessage == nil || emailErrorMessage == nil || passwordErrorMessage == nil || confirmationErrorMessage == nil
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
