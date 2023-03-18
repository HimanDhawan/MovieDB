//
//  ParameterEncoderError.swift
//  CustomerPortal
//
//  Created by Nipun Rajput on 15/11/19.
//  Copyright © 2019 Paymentus. All rights reserved.
//


import Foundation


///Enum carrying the errors used with **ParameterEncoder** .
enum ParameterEncoderError: Error {
    
    case parametersNil
    
    case encodingFailed
    
    case missingURL
}


///Extension for providing a localized description
extension ParameterEncoderError {
    
    var localizedDescription: String {
        
        switch self {
            
        case .parametersNil:
            return "Parameters were nil."
            
        case .encodingFailed:
            return "Parameter encoding failed."
            
        case .missingURL:
            return "URL is nil."
        }
    }
}
