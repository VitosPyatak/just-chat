import SwiftUI

struct FormFieldView: View {
    var formField: FormField
    @State var fieldInput = ""
    
    var body: some View {
        HStack {
            if formField.isSecured {
                SecureField(formField.placeholder, text: $fieldInput)
            } else {
                TextField(formField.placeholder, text: $fieldInput)
            }
        }
        .autocapitalization(.none)
        .disableAutocorrection(true)
        .opacity(0.5)
    }
}
