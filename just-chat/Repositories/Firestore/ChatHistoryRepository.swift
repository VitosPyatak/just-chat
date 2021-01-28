import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct ChatHistoryRepository {
    static let `default` = ChatHistoryRepository()
    
    private let collection = Firestore.firestore().collection(FirestoreCollections.chatHistory)
    
    private init() {}
    
    func save(_ message: TextMessage, completion: @escaping (Error?) -> Void) {
        do {
            let _ = try collection.document(message.id).setData(from: message)
        } catch let error {
            completion(error)
        }
    }
}
