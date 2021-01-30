import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    @State private var showingImagePicker = false
    @State private var image: Image?
    
    @EnvironmentObject var userSession: UserSession
    @State var email = ""
    @State var password = ""
    @State var inputImage: UIImage?

    
    var body: some View {
        VStack {
            Spacer()
            Text("Create your account")
                .font(.largeTitle).foregroundColor(Color.white)
                .padding([.top, .bottom], 40)
            Spacer()
            VStack(alignment: .center, spacing: 15) {
                
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
            Button(action: {
                createAccount()
                uploadToStorage()
            }) {
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
        .sheet(isPresented: self.$showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
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
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    func uploadToStorage() {
        StorageService.default.uploadImage(self.inputImage!, imageName: "user-profile.png")
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
