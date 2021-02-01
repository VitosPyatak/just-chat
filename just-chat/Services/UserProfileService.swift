//
//  UserProfileService.swift
//  just-chat
//
//  Created by Andrii on 1/31/21.
//

import Foundation


struct UserProfileService {
    private static let dataService = UserDefaults.standard
    
    private static let encoder = JSONEncoder()
    private static let decoder = JSONDecoder()
    
    private static let repositoryKey = UserDefaultsKeys.userProfile
    
    static func getUserProfile() -> UserProfile? {
        guard let userProfile = dataService.object(forKey: repositoryKey) else {
            return nil
        }
        
        do {
            return try decoder.decode(UserProfile.self, from: userProfile as! Data)
        }
        catch {
            return nil
        }
    }
    
    static func saveUserProfile(_ userProfile: UserProfile) {
        do {
            let userProfileData = try encoder.encode(userProfile)
            dataService.setValue(userProfileData, forKey: repositoryKey)
        } catch {
            print("Error saving user profile")
        }
    }
}
