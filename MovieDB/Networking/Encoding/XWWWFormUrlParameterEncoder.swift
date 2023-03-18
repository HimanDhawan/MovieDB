//
//  XWWWFormUrlEncoded.swift
//  CustomerPortal
//
//  Created by Nipun Rajput on 18/11/19.
//  Copyright © 2019 Paymentus. All rights reserved.
//

import Foundation


struct XWWWFormUrlParameterEncoder: ParameterEncoderProtocol {
    
    ///Confirms **ParameterEncoderProtocol** to satsify its constraint of encoding parameters. It will encode JSON parameters sent with the httpBody with x-www-form-urlencoded format
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) {
        
        if !parameters.isEmpty {
            
            var encoded = ""
            
            ///Create a format like: "key=value&key=value&key=value" and then encode t with .utf8
            for (key, value) in parameters {
                encoded +=  "\(key)=\(value)&"
            }
            
            encoded = String(encoded.dropLast())
            //MOBL-1615
            encoded = encoded.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
            let jsonData = encoded.data(using: .utf8)
            
            urlRequest.httpBody = jsonData
        }
    }
}
