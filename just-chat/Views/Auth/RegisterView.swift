import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    @EnvironmentObject var userSession: UserSession
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            Spacer()
            Text("Create your account")
                .font(.largeTitle).foregroundColor(Color.white)
                .padding([.top, .bottom], 40)
            Spacer()
            VStack(alignment: .leading, spacing: 15) {
                TextField("Email address", text: $email)
                    .padding()
                    .background(Color.white)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .cornerRadius(20.0)
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20.0)
            }
                .disableAutocorrection(true)
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
