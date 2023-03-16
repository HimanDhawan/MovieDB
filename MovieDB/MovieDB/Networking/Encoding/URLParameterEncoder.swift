//
//  URLParameterEncoder.swift
//  CustomerPortal
//
//  Created by Nipun Rajput on 15/11/19.
//  Copyright © 2019 Paymentus. All rights reserved.
//

import Foundation

///Confirms to **ParameterEncoderProtocol** to satsify its constraint of encoding parameters. It will encode URL query parameters sent with the request.
struct URLParameterEncoder: ParameterEncoderProtocol {
    
    ///Takes dictionary parameters and encode them to make them safe to be passed as URLQueryItem in the URLRequest
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = urlRequest.url else {throw ParameterEncoderError.missingURL}
        
        //Only execute if there are parameters to encode
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                
                urlComponents.queryItems?.append(queryItem)
            }
            
            urlRequest.url = urlComponents.url
        }
    }
}
