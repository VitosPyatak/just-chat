//
//  File.swift
//  just-chat
//
//  Created by Andrii on 1/30/21.
//

import SwiftUI

class RegistrationViewModel: ObservableObject {
    
    @Published private(set) var brokenRules = [BrokenRule]()
    
    @Validated(.nonEmpty(errorMessage: "Username is empty") && .longerThan(5, errorMessage: "Username should be at least 5 symbols"))
    var username: String? = ""
    
    @Validated(.nonEmpty(errorMessage: "Email is empty") && .isEmail(errorMessage: "Email doesn't valid"))
    var email: String? = ""
    
    @Validated(.nonEmpty(errorMessage: "Password is empty") && .longerThan(8, errorMessage: "Password should be at least 8 symbols"))
    var password: String? = ""
    
    @Validated(.nonEmpty(errorMessage: "Password is empty"))
    var passwordConfirmation: String?
    
    
    func register(withImage imageUrl: String) {
        if self.validate() {
            // register the user
        }
    }
    
    func validate() -> Bool {
        self.brokenRules.removeAll()
        
        let rules = [
            "Username": _username.validationError,
            "Email": _email.validationError,
            "Password": _password.validationError
        ]
        
        _ = rules.compactMap { pair in
            guard let errorMessage = pair.1?.failureReason else {
                return
            }
            
            self.brokenRules.append(BrokenRule(propertyName: pair.0, message: "\(errorMessage.components(separatedBy: "\n")[0])"))
        }
        
        if (passwordConfirmation != nil && !passwordConfirmation!.isEmpty && password != passwordConfirmation) {
            brokenRules.append(BrokenRule(propertyName: "Passwords", message: "Passwords doesn't match"))
        }
        
        return self.brokenRules.count == 0
        
    }
}
