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
    
    private let storage = Storage.storage(url: "gs://just-chat-bc717.appspot.com").reference()
    
    
    func uploadImage(_ image: UIImage, imageName: String) -> String {
        let imageRef = storage.child("images").child(imageName)
        
        let data = image.pngData()!

        _ = imageRef.putData(data, metadata: nil) { (metadata, error) in
          guard let metadata = metadata else {
            print(error)
            return
          }
            imageRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
                print(error)
              return
            }
            print("Download url: ", downloadURL)
          }
        }
        
        return ""
    }
}
