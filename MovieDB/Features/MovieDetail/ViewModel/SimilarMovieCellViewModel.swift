//
//  SimilarMovieCellViewModel.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/19/23.
//

import Foundation
import UIKit

class SimilarMovieCellViewModel : ObservableObject {
    
    let movie : Movies
    let dataService : SimilarMovieCellDataServiceProtocol
    
    @Published var image : UIImage? = nil
    var error : Bool = false
    
    init(movie: Movies, dataService : SimilarMovieCellDataServiceProtocol = SimilarMovieCellDataService()) {
        self.movie = movie
        self.dataService = dataService
    }
    
    func getImageURL() async {
        do {
            
            let image = try await dataService.getImageURL(movie: self.movie)
            await MainActor.run(body: {
                self.image = image
                error = false
            })
            
        } catch {
            await MainActor.run(body: {
                self.image = UIImage(systemName: "photo.artframe")
                self.error = true
            })
            
            print(error)
        }
        
        
    }
    
}
