//
//  CastMovieCellViewModel.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/29/23.
//

import Foundation

class CastMovieCellViewModel {
    
    let cast : Cast
    
    init(cast: Cast) {
        self.cast = cast
    }
    
    func getImageURL() -> URL? {
        guard let urlString = try? URLConfig().imageBaseURL(original: false).absoluteString, let posterPath = cast.profilePath else {
            return nil
        }
        return URL(string: urlString + posterPath)
    }
    
}
