import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    @EnvironmentObject var userSession: UserSession
    @State var email = ""
    @ObservedObject var registrationForm = RegistrationViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Create your account")
                .font(.largeTitle)
                .foregroundColor(Color.white)
                .padding([.top, .bottom], 40)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 15) {
                TextField("Username", text: $registrationForm.username.bound)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .modifier(WithError(error: findRuleByPropertyName("Username")))
                
                TextField("Email address", text: $registrationForm.email.bound)
                    .padding()
                    .background(Color.white)
                    .keyboardType(.emailAddress)
                    .cornerRadius(20.0)
                    .modifier(WithError(error: findRuleByPropertyName("Email")))
                
                SecureField("Password", text: $registrationForm.password.bound)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .modifier(WithError(error: findRuleByPropertyName("Password")))
                
                SecureField("Password confirmation", text: $registrationForm.passwordConfirmation.bound)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .modifier(WithError(error: findRuleByPropertyName("Passwords")))
                
            }
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding([.leading, .trailing], 27.5)
            
            Spacer()
            
            Button("Create") {
                withAnimation {
                    if (self.registrationForm.validate()) {
                        self.registrationForm.register(withImage: "")
                    }
                }
            }.font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 300, height: 50)
            .background(Color.blue)
            .cornerRadius(15.0)
            
            Spacer()
            
        }
        .background(PageViewData.Colors.firstScreen)
        .ignoresSafeArea()
    }
    
    private func createAccount() {
        //        userSession.singUp(username: $username.wrappedValue, email: $email.wrappedValue, password: $password.wrappedValue, confirmation: $confirmation.wrappedValue, completion: onCreateCompletionHandler)
    }
    
    private func onCreateCompletionHandler(result: AuthDataResult?, error: Error?) {
        if error != nil {
            print("Error while creating user")
        }
    }
    
    private func findRuleByPropertyName(_ propertyName: String) -> BrokenRule? {
        if let brokenRule = self.registrationForm.brokenRules.first(where: {
            $0.propertyName == propertyName
        }) {
            return brokenRule
        }
        return nil
    }
}

struct WithError: ViewModifier {
    var error: BrokenRule?
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            content
            if let unwrappedError = error {
                Text(unwrappedError.message)
                    .padding(5)
                    .transition(.asymmetric(insertion: .opacity, removal: .opacity))
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
