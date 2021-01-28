import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    @EnvironmentObject var userSession: UserSession
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            Text("Create an account")
            TextField("Email address", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            SecureField("Password", text: $password)
            Button(action: createAccount) {
                Text("Create account")
            }
        }
        
    }
    
    private func createAccount() {
        userSession.singUp(email: $email.wrappedValue, password: $password.wrappedValue, completion: onCreateCompletionHandler)
    }
    
    private func onCreateCompletionHandler(result: AuthDataResult?, error: Error?) {
        if error != nil {
            print("Error while creating user")
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
