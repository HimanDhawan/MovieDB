//
//  LoginError.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/21/23.
//

import Foundation

enum LoginError: Error {
    case inCorrectAPIToken
    
    case inUserNamePassword
    
    case invalidSession
}

extension LoginError : LocalizedError {
    var localizedDescription: String {
        get{
            switch self {
                
            case .inCorrectAPIToken:
                return "Invalid api token"
            case .inUserNamePassword:
                return "Invalid usernmame/password"
            case .invalidSession:
                return "Invalid session"
            }
        }
    }
}
