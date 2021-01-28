import Foundation




enum MessageType {
    case text
    
    func get() -> String {
        switch self {
        default:
            return MessageTypes.text
            
        }
    }
    
    private enum MessageTypes {
        static let text = "text"
    }
}
