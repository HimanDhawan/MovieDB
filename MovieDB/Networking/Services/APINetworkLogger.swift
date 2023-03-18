//
//  APINetworkLogger.swift
//  CustomerPortal
//
//  Created by Nipun Rajput on 21/11/19.
//  Copyright © 2019 Paymentus. All rights reserved.
//

import Foundation


///This class will log the request and response passed through arguments on console.
class APINetworkLogger {
    
    static func log(request: URLRequest) {
        
        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")": ""
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        let headers = "\(request.allHTTPHeaderFields ?? [:])"
        
        var logOutput = """
                        \(urlAsString) \n\n
                        \(method) \(query) HTTP/1.1 \n
                        HOST: \(host)\n
                        Headers: \(headers)\n
                        """
        for (key, value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
        
        print(logOutput)
    }
}
