//
//  LoginResult.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/21/23.
//

import Foundation

struct LoginResult : Codable {
    let success : Bool
    let requestToken : String?
    let statusMessage : String?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case requestToken = "request_token"
        case statusMessage = "status_message"
    }
}
