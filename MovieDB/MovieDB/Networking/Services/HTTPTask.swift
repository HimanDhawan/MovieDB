//
//  HTTPTask.swift
//  CustomerPortal
//
//  Created by Nipun Rajput on 15/11/19.
//  Copyright © 2019 Paymentus. All rights reserved.
//


import Foundation


public typealias HTTPHeaders = [String: String]


///Enum which carries different types of **HTTPTask** options which can help in encoding url and body parameters and adding headers to a request.
enum HTTPTask {
    
    ///An **HTTPTask** which carries a blank request with just a url and no body parameters, url parameters or headers.
    case request
    
    ///An **HTTPTask** which could (optional) carry a request with body parameters and url parameters.
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoder,
        urlParameters: Parameters?)
    
     ///An **HTTPTask** which could (optional) carry a request with body parameters, url parameters and headers.
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoder,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)
}
