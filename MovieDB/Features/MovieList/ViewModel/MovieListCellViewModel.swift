//
//  MovieListCellViewModel.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/18/23.
//

import Foundation

class MovieListCellViewModel {
    func getImageURL(movie : Movies) -> URL? {
        guard let urlString = try? URLConfig().imageBaseURL().absoluteString, let posterPath = movie.posterPath else {
            return nil
        }
        return URL(string: urlString + posterPath)
    }
}
