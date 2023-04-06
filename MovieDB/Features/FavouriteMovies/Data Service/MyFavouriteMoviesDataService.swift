//
//  MyFavouriteMoviesDataService.swift
//  MovieDB
//
//  Created by Himan Dhawan on 4/2/23.
//

import Foundation

protocol MyFavouriteMovieDetailsProtocol {
    init(accountID: String, sessionID : String)
    var router : APIRouter<UserProfileAPIRequest> {get}
    func getFavouriteMovies() async throws -> [Movies]
}

class MyFavouriteMovieDataService : MyFavouriteMovieDetailsProtocol {
    var router: APIRouter<UserProfileAPIRequest> = APIRouter<UserProfileAPIRequest>()
    let token = "076c9dad29e213f91dbbe7a82aa1da1d"
    let sessionID : String
    let accountID : String
    
    required init(accountID: String, sessionID: String) {
        self.accountID = accountID
        self.sessionID = sessionID
    }
    
    
    func getFavouriteMovies() async throws -> [Movies] {
        let data : MovieResultData = try await self.router.request(.getUserFavourite(apiKey: token, sessionID: sessionID, movieID: accountID))
        return data.results
    }

}
