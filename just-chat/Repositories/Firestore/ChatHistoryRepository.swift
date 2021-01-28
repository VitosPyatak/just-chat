import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct ChatHistoryRepository {
    static let `default` = ChatHistoryRepository()
    
    private let collection = Firestore.firestore().collection(FirestoreCollections.chatHistory)
    
    private var snapshotListener: ListenerRegistration
    
    private init() {}
    
    func saveMessage(_ message: TextMessage, completion: @escaping (Error?) -> Void) {
        do {
            let _ = try collection.document(message.id).setData(from: message)
        } catch let error {
            completion(error)
        }
    }
    
    mutating func registerMessageRecievingListener(snapshotProcessor: @escaping (_ snapshot: QuerySnapshot?, _ error: Error?) -> Void) {
        snapshotListener = collection.addSnapshotListener(snapshotProcessor)
    }
    
    func removeSnapshotListener() {
        snapshotListener.remove()
    }
}
