//
//  MovieDetailViewModel.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/18/23.
//

import Foundation

class MovieDetailViewModel {
    let movie : Movies
    
    init(movie: Movies) {
        self.movie = movie
    }
    
    func getImageURL() -> URL? {
        guard let urlString = try? URLConfig().imageBaseURL(original: true).absoluteString, let posterPath = movie.posterPath else {
            return nil
        }
        print("urlString + posterPath \(urlString + posterPath)")
        return URL(string: urlString + posterPath)
    }
}


