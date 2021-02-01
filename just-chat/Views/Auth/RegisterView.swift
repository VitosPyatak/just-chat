import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    @EnvironmentObject var userSession: UserSession
    @ObservedObject var registrationForm = RegistrationViewModel()
    
    @State private var showingImagePicker = false
    @State private var image: Image?
    @State var inputImage: UIImage?
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Create your account")
                .font(.largeTitle)
                .foregroundColor(Color.white)
                .padding([.top, .bottom], 40)
            
            Spacer()
            
            VStack {
                if image != nil {
                    image?
                        .resizable()
                        .frame(width: 200.0, height: 200.0)
                        .cornerRadius(100.0)
                        .scaledToFit()
                } else {
                    Button(action: {
                        self.showingImagePicker.toggle()
                    }) {
                        Text("Select a picture")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 200, height: 200)
                            .background(Color.purple)
                            .cornerRadius(100.0)
                    }
                }
            }.onTapGesture {
                self.showingImagePicker.toggle()
            }
            
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
                        processSignUp()
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
        .sheet(isPresented: self.$showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    
    private func processSignUp() {
        let imageUrl = uploadToStorage()
        createAccount(imageUrl)
    }
    
    private func createAccount(_ imageUrl: String) {
        userSession.singUp(form: self.registrationForm, imageUrl: imageUrl, completion: onCreateCompletionHandler)
    }
    
    private func onCreateCompletionHandler(result: AuthDataResult?, error: Error?) {
        if error != nil {
            print("Error while creating user")
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    func uploadToStorage() -> String {
        return StorageService.default.uploadImage(self.inputImage!, imageName: self.registrationForm.username.bound + "-profile-image.png")
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
