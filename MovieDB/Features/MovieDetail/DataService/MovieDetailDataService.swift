//
//  MovieDetailDataService.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/28/23.
//

import Foundation
import UIKit

protocol MovieDetailDataServiceProtocol {
    var router : APIRouter<MoviesAPIRequest> {get}
    func getImage(movie : Movies, original : Bool) async throws -> UIImage
    func getSimilarMovies(movie : Movies) async throws -> [Movies]
    func getCasts(movie : Movies) async throws -> [Cast]
}

class MovieDetailDataService: MovieDetailDataServiceProtocol {
    
    var router: APIRouter<MoviesAPIRequest>
    
    let token = "076c9dad29e213f91dbbe7a82aa1da1d"
    
    init(router: APIRouter<MoviesAPIRequest> = APIRouter<MoviesAPIRequest>()) {
        self.router = router
    }
    
    func getImage(movie : Movies, original : Bool) async throws -> UIImage {
        guard let urlString = try? URLConfig().imageBaseURL(original: original).absoluteString, let posterPath = movie.posterPath, let url = URL.init(string: urlString + posterPath) else {
            throw NSError.init(domain: "", code: 1)
        }
        
        let (data,_) = try await URLSession.shared.data(for: .init(url: url))
        if let image =  UIImage(data: data) {
            return image
        } else {
            throw NSError.init(domain: "Image not found", code: 1)
        }
    }
    
    func getSimilarMovies(movie : Movies) async throws -> [Movies] {

        let list : MovieResultData = try await router.request(.similarMovies(apiKey: token, movieID: movie.id.description))
        return list.results
        
    }
    
    func getCasts(movie: Movies) async throws -> [Cast] {
        let data : CastResultData = try await router.request(.cast(apiKey: token, movieID: movie.id.description))
        return data.cast
    }
    
}
