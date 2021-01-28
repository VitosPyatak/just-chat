import Foundation
import SwiftUI

enum FormFieldType {
    case email
    case password
    
    func keyboardType() -> UIKeyboardType {
        switch self {
        default:
            return .emailAddress
        }
    }
    
    func isSecured() -> Bool {
        switch self {
        case .password:
            return true
        default:
            return false
        }
    }
    
    func placeholder() -> String {
        switch self {
        case .email:
            return AuthFormPlaceholders.email
        default:
            return AuthFormPlaceholders.password
        }
    }
}
