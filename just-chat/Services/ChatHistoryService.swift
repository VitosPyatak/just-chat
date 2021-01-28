import Foundation
import FirebaseFirestore

struct ChatHistoryService {
    static var `default` = ChatHistoryService()
    
    private var chatHistoryRepository = ChatHistoryRepository.default
    
    private init() {}
    
    public func sendTextMessage(text: String, completion: @escaping (Error?) -> Void) {
        let textMessage = TextMessageBuilder.build(from: text)
        chatHistoryRepository.saveMessage(textMessage, completion: completion)
    }
    
    public func registerSnapshotListener(onMessageReceived: @escaping (TextMessage?, Error?) -> Void) {
        chatHistoryRepository.registerMessageRecievingListener { snapshot, error in
            if let snapshot = snapshot {
                for documentSnap in snapshot.documentChanges where documentSnap.type == .added {
                    parseReceivingMessage(documentSnap: documentSnap.document, onReceived: onMessageReceived)
                }
            }
        }
    }
    
    public func removeSnaphostListener() {
        chatHistoryRepository.removeSnapshotListener()
    }
    
    private func parseReceivingMessage(documentSnap: QueryDocumentSnapshot, onReceived: @escaping (TextMessage?, Error?) -> Void) {
        do {
            let message = try documentSnap.data(as: TextMessage.self)!
            onReceived(message, nil)
        } catch let error {
            onReceived(nil, error)
        }
    }
}
