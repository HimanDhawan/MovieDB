//
//  RequestToken.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/15/23.
//

import Foundation

struct RequestToken : Codable {
    let success : Bool
    let requestToken : String
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case requestToken = "request_token"
    }
}
