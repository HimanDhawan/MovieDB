//
//  MovieListCellViewModel.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/18/23.
//

import Foundation
import UIKit


class MovieListCellViewModel : ObservableObject {
    
    let movie : Movies
    let dataService : MovieListCellDataServiceProtocol
    
    @Published var image : UIImage? = nil
    
    init(movie : Movies, dataService : MovieListCellDataServiceProtocol) {
        self.movie = movie
        self.dataService = dataService
    }
    
    func getImageURL() async {
        do {
            
            let image = try await dataService.getImageURL(movie: self.movie)
            await MainActor.run(body: {
                self.image = image
            })
            
        } catch {
            await MainActor.run(body: {
                self.image = UIImage(systemName: "photo.artframe")
            })
            
            print(error)
        }
        
        
    }
}
