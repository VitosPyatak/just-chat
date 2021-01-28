import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct ChatHistoryRepository {
    static let `default` = ChatHistoryRepository()
    
    private let collection = Firestore.firestore().collection(FirestoreCollections.chatHistory)
    
    private init() {}
    
    func saveMessage(_ message: TextMessage, completion: @escaping (Error?) -> Void) {
        do {
            let _ = try collection.document(message.id).setData(from: message)
        } catch let error {
            completion(error)
        }
    }
    
    func registerMessageRecievingListener(onMessageRecieved: @escaping (_ data: TextMessage?, _ err: Error?) -> Void) {
        collection.addSnapshotListener { snap, error in
            if let error = error {
                return onMessageRecieved(nil, error);
            }
            
            guard let snapshotData = snap else { return }
            snapshotData.documentChanges.forEach { document in
                if document.type == .added {
                    let message = try! document.document.data(as: TextMessage.self)!
                    onMessageRecieved(message, error)
                }
            }
        }
    }
}
