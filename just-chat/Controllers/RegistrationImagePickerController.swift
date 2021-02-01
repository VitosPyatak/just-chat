//
//  RegistrationImagePickerController.swift
//  just-chat
//
//  Created by Andrii on 1/30/21.
//

import Foundation
import SwiftUI

struct RegistrationImagePickerController {
    
    func uploadToStorage(image: UIImage, username: String) -> String {
        StorageService.default.uploadImage(image, imageName: username + "-profile-image.png")
    }
    
}
