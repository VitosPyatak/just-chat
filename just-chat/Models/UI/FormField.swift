import Foundation
import SwiftUI

struct FormField {
    var fieldType: FormFieldType
    
    init(fieldType: FormFieldType) {
        self.fieldType = fieldType
    }
    
    var isSecured: Bool { fieldType.isSecured() }
    var placeholder: String { fieldType.placeholder() }
    var keyboardType: UIKeyboardType { fieldType.keyboardType() }
}
