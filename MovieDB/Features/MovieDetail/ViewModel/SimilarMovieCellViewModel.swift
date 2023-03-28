//
//  SimilarMovieCellViewModel.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/19/23.
//

import Foundation

class SimilarMovieCellViewModel {
    
    let movie : Movies
    
    init(movie: Movies) {
        self.movie = movie
    }
    
    func getImageURL() -> URL? {
        guard let urlString = try? URLConfig().imageBaseURL(original: false).absoluteString, let posterPath = movie.posterPath else {
            return nil
        }
        return URL(string: urlString + posterPath)
    }
    
}
