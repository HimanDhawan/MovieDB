//
//  MoviesAPIRequest.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/17/23.
//

import Foundation


enum MoviesAPIRequest {
    
    ///  Get all popular moviews
    case getMovies(apiKey : String)
    
}

extension MoviesAPIRequest: APIRequestProtocol {
    
    var path: String {
        switch self {
        case .getMovies:
            return "movie/popular"
        }
        
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getMovies: return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getMovies(apiKey: let apiKey): do {
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["api_key" : apiKey], additionHeaders: nil)
        }
        }
        
    }
    
    var headers: HTTPHeaders? {
        [:]
    }
    
}
