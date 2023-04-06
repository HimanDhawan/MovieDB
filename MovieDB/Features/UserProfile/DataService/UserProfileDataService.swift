//
//  UserProfileDataService.swift
//  MovieDB
//
//  Created by Himan Dhawan on 4/1/23.
//

import Foundation

protocol UserProfileDataServiceProtocol  {
    var router : APIRouter<UserProfileAPIRequest> {get}
    var sessionID : String {get}
    func getAccountDetails() async throws -> UserDetails
}

class UserProfileDataService: UserProfileDataServiceProtocol {
    
    let router: APIRouter<UserProfileAPIRequest>
    let token = "076c9dad29e213f91dbbe7a82aa1da1d"
    let sessionID : String
    
    init(router: APIRouter<UserProfileAPIRequest> = APIRouter<UserProfileAPIRequest>(), sessionID : String) {
        self.router = router
        self.sessionID = sessionID
    }
    
    func getAccountDetails() async throws -> UserDetails {
        let data : UserDetails = try await router.request(.getUserDetail(apiKey: token, sessionID: sessionID))
        return data
    }
    
    
}
