import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var userSession: UserSession
    @ObservedObject var loginViewModel = AuthFormViewModel()
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Enter the chat")
                .font(.largeTitle).foregroundColor(Color.white)
                .padding([.top, .bottom], 40)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 15) {
               
                TextField(AuthFormPlaceholders.email, text: $email)
                    .padding()
                    .background(Color.white)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .cornerRadius(20.0)
                
                SecureField(AuthFormPlaceholders.password, text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20.0)
            }
                .padding([.leading, .trailing], 27.5)
                .autocapitalization(.none)
                .disableAutocorrection(true)
           
            Spacer()
            
            Button(action: loginToAccount) {
                Text(ButtonPlaceholders.login)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .cornerRadius(15.0)
            }
            
            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.pink, .blue]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all))
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
