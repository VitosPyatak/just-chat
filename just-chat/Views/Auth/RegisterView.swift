import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    @EnvironmentObject var userSession: UserSession
    @State var email = ""
    @State var password = ""
    @State var confirmation = ""
    @State var username = ""
    
    var body: some View {
        VStack {
            
            Text("Create your account")
                .font(.largeTitle).foregroundColor(Color.white)
                .padding([.top, .bottom], 40)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 15) {
                
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.white)
                        .autocapitalization(.none)
                        .cornerRadius(20.0)
                        .modifier(WithError(message: userSession.usernameErrorMessage ?? ""))
                
                    TextField("Email address", text: $email)
                        .padding()
                        .background(Color.white)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .cornerRadius(20.0)
                        .modifier(WithError(message: userSession.emailErrorMessage ?? ""))
                
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20.0)
                        .modifier(WithError(message: userSession.passwordErrorMessage ?? ""))
                
                    SecureField("Password confirmation", text: $confirmation)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20.0)
                        .modifier(WithError(message: userSession.confirmationErrorMessage ?? ""))
                
            }
                .padding([.leading, .trailing], 27.5)
            
            Spacer()
            
            Button(action: createAccount) {
                Text("Create")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }
            
            Spacer()
            
        }
        .background(PageViewData.Colors.firstScreen)
        .ignoresSafeArea()
    }
    
    private func createAccount() {
        userSession.singUp(username: $username.wrappedValue, email: $email.wrappedValue, password: $password.wrappedValue, confirmation: $confirmation.wrappedValue, completion: onCreateCompletionHandler)
    }
    
    private func onCreateCompletionHandler(result: AuthDataResult?, error: Error?) {
        if error != nil {
            print("Error while creating user")
        }
    }
}

struct WithError: ViewModifier {
    var message: String
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            if (message.isEmpty) {
                content.padding(.bottom, 0)
                Text(message).padding(.top);
            } else {
                content
                Text(message).padding(5)
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
