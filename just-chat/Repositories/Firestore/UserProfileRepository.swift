//
//  UserProfileRepository.swift
//  just-chat
//
//  Created by Andrii on 1/30/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct UserProfileRepository {
    static let `default` = UserProfileRepository()
    
    private let collection = Firestore.firestore().collection(FirestoreCollections.userProfile)
        
    private init() {}
    
    func saveMessage(_ message: TextMessage, completion: @escaping (Error?) -> Void) {
        do {
            let _ = try collection.document(message.id).setData(from: message)
        } catch let error {
            completion(error)
        }
    }
    
    func registerMessageRecievingListener(snapshotProcessor: @escaping (_ snapshot: QuerySnapshot?, _ error: Error?) -> Void) -> ListenerRegistration {
        collection.addSnapshotListener(snapshotProcessor)
    }
    
    func removeSnapshotListener(snapshotListener: ListenerRegistration) {
        snapshotListener.remove()
    }
}
