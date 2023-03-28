//
//  UserSession.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/21/23.
//

import Foundation

struct UserSession : Codable {
    let success : Bool
    let sessionID : String?
    let statusMessage : String?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case sessionID = "session_id"
        case statusMessage = "status_message"
    }
}
