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
    
    case similarMovies(apiKey : String, movieID : String)
    
}

extension MoviesAPIRequest: APIRequestProtocol {
    
    var path: String {
        switch self {
        case .getMovies:
            return "movie/popular"
        case .similarMovies(apiKey: _, movieID : let movieID):
            return "movie/\(movieID)/similar"
        }
        
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getMovies,.similarMovies: return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getMovies(apiKey: let apiKey),.similarMovies(apiKey: let apiKey, movieID: _): do {
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["api_key" : apiKey], additionHeaders: nil)
        }
        }
        
    }
    
    var headers: HTTPHeaders? {
        [:]
    }
    
}
