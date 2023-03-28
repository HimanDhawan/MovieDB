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
    
    @Published var selectedMovie: Movies? = nil
    @Published var isSelected: Bool = false
    
    let movieListService : MovieListDataServiceProtocol
    
    init(movieListService: MovieListDataServiceProtocol) {
        self.movieListService = movieListService
    }
    
    func getAllPopularMovies() async {
        do {
            self.movies = try await self.movieListService.getAllPopularMovies()
            self.moviesCount = self.movies.count.description
        } catch {
            print("Error \(error)")
        }

    }
    
}
