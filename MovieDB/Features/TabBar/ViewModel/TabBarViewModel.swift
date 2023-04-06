//
//  TabBarViewModel.swift
//  MovieDB
//
//  Created by Himan Dhawan on 4/1/23.
//

import Foundation


class TabBarViewModel : ObservableObject {
    
    @Published var movies : [Movies]? = nil
    @Published var userDetails : UserDetails? = nil
    
    @Published var errorMessage : String? = nil
    
    let movieListService : MovieListDataServiceProtocol
    let profileDataService : UserProfileDataServiceProtocol
    
    init(movieListService: MovieListDataServiceProtocol, profileDataService : UserProfileDataServiceProtocol) {
        self.movieListService = movieListService
        self.profileDataService = profileDataService
    }
    
    func getData() async {
        do {
            async let data1  = try await self.movieListService.getAllPopularMovies()
            async let data2  = try await self.profileDataService.getAccountDetails()
            let (movieData,userDetails) = try await (data1,data2)
            await MainActor.run(body: {
                self.movies = movieData
                self.userDetails = userDetails
                errorMessage = nil
            })
        } catch {
            await MainActor.run(body: {
                errorMessage = error.localizedDescription
            })
            print("Error \(error)")
        }

    }
    
}
