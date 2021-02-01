//
//  Validation+Extensions.swift
//  just-chat
//
//  Created by Andrii on 1/30/21.
//

import Foundation

extension Validation where Value == String {
    
    static func nonEmpty(errorMessage: String = "Is Empty") -> Validation {
        return .init { value in
            value.isEmpty ? .failure(.init(message: errorMessage)) : .success(())
        }
    }
    
    static func isEmail(errorMessage: String = "Is Empty") -> Validation {
        let regex = NSRegularExpression("[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}")
        return .init { value in
            !regex.matches(value) ? .failure(.init(message: errorMessage)) : .success(())
        }
    }
    
    static func longerThan(_ longerThan: Int, errorMessage: String = "Doesn't have enough symbols") -> Validation {
        return .init { value in
            value.count < longerThan ? .failure(.init(message: errorMessage)) : .success(())
        }
    }
    
}
