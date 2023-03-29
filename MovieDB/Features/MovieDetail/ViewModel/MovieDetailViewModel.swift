//
//  MovieDetailViewModel.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/18/23.
//

import Foundation
import Combine
import UIKit

class MovieDetailViewModel : ObservableObject {
    let movie : Movies
    
    @Published var cast : [Cast] = []
    @Published var similarMovies : [Movies] = []
    @Published var image : UIImage? = nil
    @Published var isOriginal : Bool = false
    
    var anyCancelabels : Set<AnyCancellable> = []
    
    let dataService : MovieDetailDataServiceProtocol
    
    init(movie: Movies, dataService : MovieDetailDataServiceProtocol) {
        self.movie = movie
        self.dataService = dataService
    }
    
    func showImage() async {
        do {
            let smallimage = try await self.dataService.getImage(movie: self.movie, original: false)
            await MainActor.run(body: {
                self.image = smallimage
                isOriginal = false
            })
            let bigImage = try await self.dataService.getImage(movie: self.movie, original: true)
            await MainActor.run(body: {
                self.image = bigImage
                isOriginal = true
            })
        } catch {
            await MainActor.run(body: {
                self.image = UIImage(systemName: "photo.artframe")
                isOriginal = true
            })
        }
    }
    
    func getSimilarMovies() async {

        do {
            let list : [Movies] = try await dataService.getSimilarMovies(movie: self.movie)
            await MainActor.run(body: {
                self.similarMovies = list
            })
            
        } catch {
            print("Error \(error)")
        }
        
    }
    
    func getCasts() async {

        do {
            let list : [Cast] = try await dataService.getCasts(movie: self.movie)
            await MainActor.run(body: {
                self.cast = list
            })
            
        } catch {
            print("Error \(error)")
        }
        
    }
    
}


