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
    @Published var movie : Movies
    
    @Published var cast : [Cast] = []
    @Published var similarMovies : [Movies] = []
    @Published var image : UIImage? = nil
    @Published var isOriginal : Bool = false
    @Published var similarMovieListError : String? = nil
    @Published var castListError : String? = nil
    
    @Published var similarMovieSelected : Movies? = nil
    
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
            if list.count == 0 {
                throw NSError.init(domain: "Similar Error", code: 101, userInfo: [NSLocalizedDescriptionKey: "No similar movies found."])
            } else {
                await MainActor.run(body: {
                    self.similarMovies = list
                })
            }
            
        } catch {
            await MainActor.run(body: {
                similarMovieListError = error.localizedDescription
            })
            
            print("Error \(error)")
        }
        
    }
    
    func getCasts() async {

        do {
            let list : [Cast] = try await dataService.getCasts(movie: self.movie)
            
            if list.count == 0 {
                throw NSError.init(domain: "Cast Error", code: 101, userInfo: [NSLocalizedDescriptionKey: "No casts found."])
            } else {
                await MainActor.run(body: {
                    self.cast = list
                })
            }
            
        } catch {
            await MainActor.run(body: {
                castListError = error.localizedDescription
            })
            print("Error \(error)")
        }
        
    }
    
}


