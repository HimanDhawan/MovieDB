//
//  MyFavouriteAppViewModel.swift
//  MovieDB
//
//  Created by Himan Dhawan on 4/2/23.
//

import Foundation


class MyFavouriteMovieViewModel : ObservableObject {
    
    @Published var movies : [Movies]? = nil
    @Published var error : String? = nil
    
    let dataService : MyFavouriteMovieDetailsProtocol
    init(dataService: MyFavouriteMovieDetailsProtocol) {
        self.dataService = dataService
    }
    
    func getFavouriteMovies() async {
        do {
            let movies = try await self.dataService.getFavouriteMovies()
            if movies.count == 0 {
                throw NSError.init(domain: "Favourite movie Error", code: 101, userInfo: [NSLocalizedDescriptionKey: "No favourite movies found."])
            } else {
                await MainActor.run(body: {
                    self.movies = movies
                })
            }
            
        } catch {
            await MainActor.run(body: {
                self.error = error.localizedDescription
            })
        }
    }
    
}
