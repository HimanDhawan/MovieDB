//
//  APIRequestProtocol.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/14/23.
//

import Foundation

///Set of rules declared for an API request. Every API request should confirm to this protocol.
protocol APIRequestProtocol {
    
    var urlConfig: URLConfig { get }
    
    ///The endpoint of a URL. For example: https://somebaseURL.com/someRoute/"<friends/list>". See **URLConfig** to check how base-URL and route is constructed.
    var path: String { get }
    
    var httpMethod: HTTPMethod { get }
    
    var task: HTTPTask { get }
    
    var timeoutInterval: TimeInterval { get }
    
    var cachePolicy: NSURLRequest.CachePolicy { get }
    
    var headers: HTTPHeaders? { get }
}


///Extension for providing default implementation to **APIResponseProtocol**'s variables.
extension APIRequestProtocol {
    
    var urlConfig: URLConfig {
        
        get {
            return URLConfig()
        }
    }
    
    var timeoutInterval: TimeInterval {
        
        get {
            return 120.0
        }
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        
        get {
            return NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        }
    }
}
