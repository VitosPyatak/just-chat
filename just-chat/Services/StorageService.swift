//
//  StorageService.swift
//  just-chat
//
//  Created by Andrii on 1/30/21.
//

import Foundation
import Firebase
import FirebaseStorage

struct StorageService {
    static let `default` = StorageService()
    
    let storage = Storage.storage(url: "gs://just-chat-bc717.appspot.com").reference()
    
    
    func uploadImage(_ image: UIImage, imageName: String) -> String {
        let imageRef = storage.child("images").child(imageName)
        
        let data = image.pngData()!
        
        _ = imageRef.putData(data, metadata: nil) { (metadata, error) in
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    return
                }
                print(downloadURL)
            }
        }

        return "images/" + imageName;
    }
}
