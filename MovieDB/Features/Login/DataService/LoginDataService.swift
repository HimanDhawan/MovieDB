//
//  LoginDataRespository.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/21/23.
//

import Foundation

protocol LoginDataServiceProtocol  {
    var router : APIRouter<OnboardingAPIRequest> {get}
    func login(userName: String, password : String) async throws -> UserSession
}

class LoginDataService : LoginDataServiceProtocol  {
    
    let router : APIRouter<OnboardingAPIRequest>
    let token = "076c9dad29e213f91dbbe7a82aa1da1d"
    
    init(router: APIRouter<OnboardingAPIRequest> = APIRouter<OnboardingAPIRequest>()) {
        self.router = router
    }
    
    func login(userName: String, password : String) async throws -> UserSession {
        do {
            let requestToken = try await getRequesToken()
            try await getLoginResult(userName: userName, password: password, requestToken: requestToken)
            let session = try await getSession(requestToken: requestToken)
            return session
        } catch {
            throw error
        }
    }
}

extension LoginDataService {
    func getRequesToken() async throws -> String {
        let requestTokenData : RequestToken = try await router.request(.createRequestToken(apiKey: token))
        guard requestTokenData.success, let requestT0ken = requestTokenData.requestToken else {
            throw NSError.init(domain: "Login Error \(requestTokenData.statusMessage ?? "")", code: 101, userInfo: [NSLocalizedDescriptionKey: LoginError.inCorrectAPIToken.localizedDescription])
        }
        return requestT0ken
    }
    
    func getLoginResult(userName: String, password : String,requestToken : String) async throws {
        let loginResult : LoginResult = try await router.request(.login(userName: userName, password: password, requestToken: requestToken, apiKey: token))
        if loginResult.success == false {
            throw NSError.init(domain: "Login Error \(loginResult.statusMessage ?? "")", code: 101, userInfo: [NSLocalizedDescriptionKey: LoginError.inUserNamePassword.localizedDescription])
        }
    }
    
    func getSession(requestToken : String) async throws -> UserSession {
        let loginSession : UserSession = try await router.request(.createSession(requestToken: requestToken, apiKey: token))
        if loginSession.success == false {
            throw NSError.init(domain: "Login Error \(loginSession.statusMessage ?? "")", code: 101, userInfo: [NSLocalizedDescriptionKey: LoginError.invalidSession.localizedDescription])
        }
        return loginSession
    }
}
