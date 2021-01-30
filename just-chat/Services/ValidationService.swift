//
//  ValidationService.swift
//  just-chat
//
//  Created by Max on 30.01.2021.
//

import Foundation

class ValidationService {
    public static func validateUsername(username: String) -> String? {
        return username.count > 2 ? nil : "Username should be 3+ symbols"
    }
    
    public static func validateEmail(email: String) -> String? {
        let regex = NSRegularExpression("[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}")
        return regex.matches(email) ? nil : "Invalid email!"
    }
    
    public static func validatePassword(password: String) -> String? {
        return password.count > 7 ? nil : "Password should be 8+ symbols"
    }
    
    public static func validateConfirmation(password: String, confirmation: String) -> String? {
        if confirmation.count < 7 {
            return "Confirmation should be 8+ symbols"
        }
        return password == confirmation ? nil : "Confirmation does not match password"
    }
}

extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
}

extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}
