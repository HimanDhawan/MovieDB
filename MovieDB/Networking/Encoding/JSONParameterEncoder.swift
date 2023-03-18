//
//  JSONParameterEncoder.swift
//  CustomerPortal
//
//  Created by Nipun Rajput on 15/11/19.
//  Copyright © 2019 Paymentus. All rights reserved.
//

import Foundation

///Confirms **ParameterEncoderProtocol** to satsify its constraint of encoding parameters. It will encode JSON parameters sent with the httpBody of the URLRequest.
struct JSONParameterEncoder: ParameterEncoderProtocol {
    
    ///Takes dictionary parameters and encode them to make them safe to be passed as httpBody in the URLRequest
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            
            urlRequest.httpBody = jsonAsData
            
        } catch {
            throw ParameterEncoderError.encodingFailed
        }
    }
}
