//
//  MovieListViewModel.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/14/23.
//

import Foundation
import Combine

class MovieListViewModel : ObservableObject {
    
    // Published variables
    @Published var movies : [Movies] = []
    @Published var moviesCount : String = "0"
    
    init(movie: [Movies]) {
        self.movies = movie
        self.moviesCount = movie.count.description
    }
    
    
}
