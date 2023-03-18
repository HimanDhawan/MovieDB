//
//  APIResponseError.swift
//  CustomerPortal
//
//  Created by Nipun Rajput on 19/11/19.
//  Copyright © 2019 Paymentus. All rights reserved.
//

import Foundation

enum APIResponseError: Error {
    
    case badRequest; case forbidden; case notFound; case serverError
    
    case noInternetConnection
    
    case requestTimeout
    
    case incorrectStatusCode
    
    case parsingError
    
    case unknown
    
    ///Process any custom/runtime errors sent from the server based on user/system input.
    case customDictionary([String: Any])
    
    ///Process internal errors and thrown exceptions. Don't use this for displaying to the end user
    case customMessage(String)
    
    ///Handles the 401,520,521,522 status from the API, which means logged out.
    case unauthorized
    
    ///Signals that everything is fine as expected, with the API response
    case none
}


///Extension for providing a localized description
extension APIResponseError: LocalizedError {
        
    var localizedDescription: String {
        
        get {
            
            switch self {
            
            case .noInternetConnection:
                return "no_internet_connection"
                
            case .requestTimeout:
                return "request_timeout"
                
            case .incorrectStatusCode:
                return "Incorrect HTTP status code."
                
            case .parsingError:
                return "unable_to_process_request"
                
            case .unknown:
                return "unable_to_process_request"
                
            case .customDictionary:
                return "Check the error in the \"errorDictionary\" variable."
                
            case .customMessage(let message):
                return message
                
            case .unauthorized:
                return "session_expire"
                
            case .none:
                return "No errors found."
                
            case .badRequest, .forbidden , .notFound, .serverError:
                return "Internal server error"
            }
        }
    }
}


///Extension for providing a key:value pair based error info/dictionary
extension APIResponseError: ErrorDataProtocol {
    
    var errorDictionary: [String: Any]? {
        
        return getErrorInfo()
    }
    
    private func getErrorInfo() -> [String: Any]? {
        
        switch self {
            
        case .customDictionary(let dictionary):
            
            return dictionary
            
        default:
            
            return nil
        }
    }
}

