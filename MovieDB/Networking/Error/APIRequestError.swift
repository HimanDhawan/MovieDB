//
//  CustomError.swift
//  CustomerPortal
//
//  Created by Nipun Rajput on 16/11/19.
//  Copyright © 2019 Paymentus. All rights reserved.
//


import Foundation


///Enum carrying the errors used with **APIRequestProtocol**
enum APIRequestError: Error {
    
    case invalidURL
    
    case environmentNotConfigured
    
    ///When data required to call an API is insufficient. This error should be handled at development side only.
    case dataMissing
}


///Extension for providing a localized description
extension APIRequestError {
    
    //These are not localized messages because these should be handled before making the request and on the developer side.
    var localizedDescription: String {
        
        get {
            
            switch self {
                
            case .invalidURL:
                return "Invalid URL."
                
            case .environmentNotConfigured:
                return "Could not find the value of BillerEnvironmentURL key in info.plist."
                
            case .dataMissing:
                return "Invalid data."
            }
        }
    }
}
