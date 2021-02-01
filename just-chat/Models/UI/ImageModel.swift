//
//  ImageModel.swift
//  just-chat
//
//  Created by Andrii on 2/1/21.
//

import Foundation
import SwiftUI

class ImageModel: ObservableObject {
    @Published var image: UIImage
    
    init(imageURL: String) {
        self.image = UIImage(systemName: "photo")!
        
        let ref = StorageService.default.storage.child(imageURL)
        
        ref.getData(maxSize: 1 * 1024 * 1024 * 1024) { data, error in
            if let error = error {
                print(error)
            } else {
                self.image = UIImage(data: data!)!
            }
        }
    }
}
