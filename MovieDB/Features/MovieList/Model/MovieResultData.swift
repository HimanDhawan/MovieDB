//
//  MovieResultData.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/18/23.
//

import Foundation


class MovieResultData : Codable {
    let page : Int
    let results : [Movies]
}

struct Movies : Codable, Identifiable {
    let id : Int
    let adult : Bool
    let originalTitle : String
    let overview : String
    let title : String
    let posterPath : String?
    let releaseDate : String?
    let voteAverage : Double
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case adult = "adult"
        case originalTitle = "original_title"
        case overview = "overview"
        case title = "title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
    
    
}
