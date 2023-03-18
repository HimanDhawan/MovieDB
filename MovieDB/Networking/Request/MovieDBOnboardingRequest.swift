//
//  MovieDBInitlizationRequest.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/15/23.
//

import Foundation

enum OnboardingAPIRequest {
    
    ///  Login with user account
    ///  - Parameters:
    ///   - username: Email/Username of the account
    ///   - password: Password
    ///   - requestToken: Request token received after login
    ///   - apiKey: The unique api key.
    case login(userName : String, password : String, requestToken : String, apiKey : String)
    
    ///  To authenticate api key.
    ///  - Parameters:
    ///   - apiKey: The unique api key.
    case createRequestToken(apiKey : String)
    
    ///  To create new session with request token and api key.
    ///  - Parameters:
    ///   - requestToken: Request token received after login
    ///   - apiKey: The unique api key.
    case createSession(requestToken : String, apiKey : String)
}

extension OnboardingAPIRequest: APIRequestProtocol {
    
    var path: String {
        switch self {
            
        case .login:
            return "authentication/token/validate_with_login"
        case .createRequestToken:
            return "authentication/token/new"
        case .createSession:
            return "authentication/session/new"
        }
        
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login: return .post
        case .createRequestToken: return .get
        case .createSession: return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .login(userName: let userName, password: let password, requestToken: let requestToken, apiKey: let apiKey): do {
            return .requestParameters(bodyParameters: ["username" : userName, "password" : password, "request_token" : requestToken], bodyEncoding: .jsonEncoding, urlParameters: ["api_key" : apiKey])
        }
                
        case .createRequestToken(apiKey: let apiKey): do {
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["api_key" : apiKey], additionHeaders: nil)
        }
        case .createSession(requestToken: let requestToken, apiKey: let apiKey):
             return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["api_key" : apiKey, "request_token" : requestToken], additionHeaders: nil)
        }
        
    }
    
    var headers: HTTPHeaders? {
        [:]
    }
    
}
