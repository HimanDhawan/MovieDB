//
//  MovieListCellViewModel.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/18/23.
//

import Foundation

class MovieListCellViewModel {
    let movie : Movies
    
    init(movie : Movies) {
        self.movie = movie
    }
    
    func getImageURL(movie : Movies) -> URL? {
        guard let urlString = try? URLConfig().imageBaseURL(original: true).absoluteString, let posterPath = movie.posterPath else {
            return nil
        }
        return URL(string: urlString + posterPath)
    }
}
