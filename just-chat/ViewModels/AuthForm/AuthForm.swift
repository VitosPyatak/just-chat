import Foundation
import SwiftUI

class AuthFormViewModel: ObservableObject {
    @Published var formFields = createFormField()
    
    func get(byIndex index: Int) -> FormField {
        formFields[index]
    }
    
    private static func createFormField() -> [FormField] {
        let formFieldTypes: [FormFieldType] = [.email, .password]
        return formFieldTypes.map { fieldType in FormField(fieldType: fieldType) }
    }
}
