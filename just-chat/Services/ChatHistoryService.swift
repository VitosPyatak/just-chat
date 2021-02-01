import Foundation
import FirebaseFirestore

struct ChatHistoryService {
    static var `default` = ChatHistoryService()
    
    private var chatHistoryRepository = ChatHistoryRepository.default
    private var textMessageBuilder = TextMessageBuilder.default
    
    private var snapshotListener: ListenerRegistration?
    
    private init() {}
    
    public func sendTextMessage(text: String, and userProfile: UserProfile, completion: @escaping (Error?) -> Void) {
        let textMessage = textMessageBuilder.build(from: text, and: userProfile)
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
        if let listener = snapshotListener {
            chatHistoryRepository.removeSnapshotListener(snapshotListener: listener)
        }
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
