//
//  UserProfile.swift
//  MovieDB
//
//  Created by Himan Dhawan on 4/1/23.
//

import Foundation

enum UserProfileAPIRequest {
    
    ///  Get all popular moviews
    case getUserDetail(apiKey : String, sessionID : String)
    
    case getUserFavourite(apiKey : String, sessionID : String, movieID : String)
    
}

extension UserProfileAPIRequest: APIRequestProtocol {
    
    var path: String {
        switch self {
        case .getUserDetail:
            return "account"
        case .getUserFavourite(apiKey: _, sessionID: _, movieID: let movieID):
            return "account/\(movieID)/favorite/movies"
        }
        
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getUserDetail,.getUserFavourite: return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getUserDetail(apiKey: let apiKey,sessionID : let sessionID): do {
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["api_key" : apiKey, "session_id" : sessionID], additionHeaders: nil)
        }
        case .getUserFavourite(apiKey: let apiKey,sessionID : let sessionID, movieID : _): do {
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["api_key" : apiKey, "session_id" : sessionID], additionHeaders: nil)
        }
        }
        
    }
    
    var headers: HTTPHeaders? {
        [:]
    }
    
}
