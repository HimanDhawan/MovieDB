//
//  Cast.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/29/23.
//

import Foundation

struct CastResultData : Codable {
    let id : Int
    let cast : [Cast]
}

struct Cast : Codable, Identifiable {
    let gender : Int
    let id : Int
    let name : String
    let profilePath : String?
    let character : String
    
    enum CodingKeys: String, CodingKey {
        case gender = "gender"
        case id = "id"
        case name = "name"
        case profilePath = "profile_path"
        case character = "character"
    }
    
}
