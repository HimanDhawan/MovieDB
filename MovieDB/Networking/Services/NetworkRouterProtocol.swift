//
//  Router.swift
//  CustomerPortal
//
//  Created by Nipun Rajput on 15/11/19.
//  Copyright © 2019 Paymentus. All rights reserved.
//


import Foundation
import Combine


///Set of rules responsible for routing various types of **APIRequestProtocol** and handling the reponse with **APIResponse**
protocol NetworkRouterProtocol {
    
    ///Associates this protocol with a generic type by the name of **APIRequest**, with a constraint of adopting APIRequestProtocol
    associatedtype Request: APIRequestProtocol
            
    ///Triggers an **APIRequest**
    func request<T : Codable>(_ route: Request) -> AnyPublisher<T, Error>
    
}

///Set of rules responsible for routing various types of **APIRequestProtocol** and handling the reponse with **APIResponse**
protocol NetworkRouterProtocol1 {
    
    ///Associates this protocol with a generic type by the name of **APIRequest**, with a constraint of adopting APIRequestProtocol
    associatedtype Request: APIRequestProtocol
    
    ///Associates this protocol with a generic type by the name of **APIResponse**, with a constraint of adopting APIResponseProtocol
    associatedtype Response: APIResponse
    
    ///Abbreviation for (APIResponse) -> Void, which is a completion block used in the **request** method of this protocol.
    typealias NetworkRouterCompletion = (Response) -> Void
    
    ///Triggers an **APIRequest**
    func request(_ route: Request, completion: @escaping NetworkRouterCompletion)
    
    ///Cancels an **APIRequest**
    func cancel()
}

//Old code. Use the NetworkRouterProtocol instead
///Set of rules responsible for routing various types of **APIRequestProtocol** and handling the reponse with **APIResponseProtocol**
//protocol NetworkRouterProtocol2 {
//    
//    ///Associates this protocol with a generic type by the name of **APIRequest**, with a constraint of adopting APIRequestProtocol
//    associatedtype APIRequest: APIRequestProtocol
//    
//    ///Associates this protocol with a generic type by the name of **APIResponse**, with a constraint of adopting APIResponseProtocol
//    associatedtype APIResponse: APIResponseProtocol
//    
//    ///Abbreviation for (APIResponse) -> Void, which is a completion block used in the **request** method of this protocol.
//    typealias NetworkRouterCompletion = (APIResponse) -> Void
//    
//    ///Triggers an **APIRequest**
//    func request(_ route: APIRequest, completion: @escaping NetworkRouterCompletion)
//    
//    ///Cancels an **APIRequest**
//    func cancel()
//}






