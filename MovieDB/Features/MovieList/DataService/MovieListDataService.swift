//
//  MovieListDataService.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/28/23.
//

import Foundation

protocol MovieListDataServiceProtocol  {
    var router : APIRouter<MoviesAPIRequest> {get}
    func getAllPopularMovies() async throws -> [Movies]
}

class MovieListDataService: MovieListDataServiceProtocol {
    
    let router: APIRouter<MoviesAPIRequest>
    let token = "076c9dad29e213f91dbbe7a82aa1da1d"
    
    init(router: APIRouter<MoviesAPIRequest> = APIRouter<MoviesAPIRequest>()) {
        self.router = router
    }
    
    func getAllPopularMovies() async throws -> [Movies] {
        let data : MovieResultData = try await router.request(.getMovies(apiKey: token))
        return data.results
    }
    
    
}
