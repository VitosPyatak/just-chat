import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var userSession: UserSession
    @ObservedObject var loginViewModel = AuthFormViewModel()
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        Form {
//            TODO: create dynamic rendering
//            ForEach(loginViewModel.formFields.indices) { fieldIndex in
//                FormFieldView(formField: getFormField(byIndex: fieldIndex))
//            }
            TextField(AuthFormPlaceholders.email, text: $email)
            SecureField(AuthFormPlaceholders.password, text: $password)
            
            Button(action: loginToAccount) {
                Text(ButtonPlaceholders.login)
            }
            
        }
        .autocapitalization(.none)
        .disableAutocorrection(true)
    }
    
    private func loginToAccount() {
        userSession.signIn(email: $email.wrappedValue, password: $password.wrappedValue, completion: onLoginCompletionHandler)
    }
    
    private func onLoginCompletionHandler(result: AuthDataResult?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        }
    }
    
    private func getFormField(byIndex index: Int) -> FormField {
        loginViewModel.get(byIndex: index)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
