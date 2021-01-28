import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var userSession: UserSession
    @State var email = ""
    @State var password = ""
    
    
    var body: some View {
        Text("Login to account")
        TextField("Email address", text: $email)
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
        SecureField("Password", text: $password)
        Button(action: loginToAccount) {
            Text("Login to account")
        }
    }
    
    private func loginToAccount() {
        userSession.signIn(email: $email.wrappedValue, password: $password.wrappedValue, completion: onLoginCompletionHandler)
    }
    
    private func onLoginCompletionHandler(result: AuthDataResult?, error: Error?) {
        if error != nil {
            print("Failed to login")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
