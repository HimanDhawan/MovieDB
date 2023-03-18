//
//  RequestBuilder.swift
//  CustomerPortal
//
//  Created by Nipun Rajput on 17/11/19.
//  Copyright © 2019 Paymentus. All rights reserved.
//


import Foundation


///Builds the URLRequest based on the configured parameters and encoding
class RequestBuilder<APIRequest: APIRequestProtocol> {
    
    ///Builds the URLRequest based on the **APIRequest** associated type.
    func buildRequest(from route: APIRequest) throws -> URLRequest {
        
        var finalURL = try route.urlConfig.baseURL()
        
        if route.urlConfig.ignoreBaseURL {
            
            if let directURL = URL.init(string: route.path) {
                
                finalURL = directURL
                
            } else {
                
                throw APIRequestError.invalidURL
            }
            
        } else {
            
            finalURL = finalURL.appendingPathComponent(route.path)
        }
        
        var request = URLRequest(url: finalURL,
                                 cachePolicy: route.cachePolicy,
                                 timeoutInterval: route.timeoutInterval)
       
        request.httpMethod = route.httpMethod.rawValue
        
        addHeaders(route.headers, request: &request)
        
        switch route.task {
            
        case .request:
            //Do something here if required.
            break
            
        case .requestParameters(let bodyParameters,
                                let bodyEncoding,
                                let urlParameters):
            
            try self.configureParameters(bodyParameters: bodyParameters,
                                         bodyEncoding: bodyEncoding,
                                         urlParameters: urlParameters,
                                         request: &request)
            
        case .requestParametersAndHeaders(let bodyParameters,
                                          let bodyEncoding,
                                          let urlParameters,
                                          let additionalHeaders):
            
            self.addHeaders(additionalHeaders, request: &request)
            try self.configureParameters(bodyParameters: bodyParameters,
                                         bodyEncoding: bodyEncoding,
                                         urlParameters: urlParameters,
                                         request: &request)
            
        }
        
        return request
    }
    
    ///Performs parameter encoding
    func configureParameters(bodyParameters: Parameters?,
                             bodyEncoding: ParameterEncoder,
                             urlParameters: Parameters?,
                             request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters,
                                    urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    
    ///Adds headers to the request
    func addHeaders(_ headers: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = headers else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
