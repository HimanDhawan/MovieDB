//
//  ParameterEncoder.swift
//  CustomerPortal
//
//  Created by Nipun Rajput on 15/11/19.
//  Copyright © 2019 Paymentus. All rights reserved.
//

import Foundation


///A type alias which represents a key-value/Dictionary pair of type String-Any.
typealias Parameters = [String: Any]

///Used for encoding data/parameters sent with the request. It could be URL parameters, Headers and httpBody parameters.
protocol ParameterEncoderProtocol {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

///Enum carrying the types of encodings for a **URLRequest**
enum ParameterEncoder {
    
    case urlEncoding
    
    case jsonEncoding
    
    case urlAndJsonEncoding
    
    case xWWWFormUrlEncoding
    
    case urlAndXWWWFormUrlEncoding
    
    // swiftlint:disable cyclomatic_complexity
    ///Encodes the URLReuqest based on the parameters and selected enum case.
    func encode(urlRequest: inout URLRequest,
                bodyParameters: Parameters?,
                urlParameters: Parameters?) throws {
        do {
            switch self {
                
            case .urlEncoding:
                guard let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                
            case .jsonEncoding:
                guard let bodyParameters = bodyParameters else { return }
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                
            case .urlAndJsonEncoding:
                guard let bodyParameters = bodyParameters,
                    let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                
            case .xWWWFormUrlEncoding:
                guard let bodyParameters = bodyParameters else { return }
                XWWWFormUrlParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                
            case .urlAndXWWWFormUrlEncoding:
                guard let bodyParameters = bodyParameters,
                    let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                XWWWFormUrlParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                
            }
            
        } catch {
            throw error
        }
        // swiftlint:enable:cyclomatic_complexity
    }
}
