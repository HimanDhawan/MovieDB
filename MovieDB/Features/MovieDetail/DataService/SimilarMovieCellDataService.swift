//
//  SimilarMovieCellDataService.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/30/23.
//

import Foundation
import UIKit

protocol SimilarMovieCellDataServiceProtocol  {
    func getImageURL(movie : Movies) async throws -> UIImage
}

class SimilarMovieCellDataService: SimilarMovieCellDataServiceProtocol {
    
    func getImageURL(movie : Movies) async throws -> UIImage {
        guard let urlString = try? URLConfig().imageBaseURL(original: false).absoluteString, let posterPath = movie.posterPath, let url = URL.init(string: urlString + posterPath) else {
            throw NSError.init(domain: "", code: 1)
        }
        
        let (data,_) = try await URLSession.shared.data(for: .init(url: url))
        if let image =  UIImage(data: data) {
            return image
        } else {
            throw NSError.init(domain: "Image not found", code: 1)
        }
        
        
    }
}
