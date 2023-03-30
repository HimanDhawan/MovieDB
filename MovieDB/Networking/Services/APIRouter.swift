//
//  APIRouter.swift
//  CustomerPortal
//
//  Created by Nipun Rajput on 19/11/19.
//  Copyright © 2019 Paymentus. All rights reserved.
//

import Foundation
import Combine


///Handles routing of a requests based on the specified generic types named **Request** and **Response**, which should adopt **APIRequestProtocol** and inherit from**APIResponse** respectively. Also, adopts **NetworkRouterProtocol** to the routing.

class APIRouter<Request: APIRequestProtocol> {
    
    ///Triggers the **Request**
    func request<Model : Codable>(_ route: Request) async throws -> Model {
                
        do {
            let request = try RequestBuilder<Request>().buildRequest(from: route)
            
            APINetworkLogger.log(request: request)
            
            let (data,_) = try await URLSession.shared.data(for: request)
            
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)

            
            return try JSONDecoder().decode(Model.self, from: data)
            
        } catch {
            throw error
        }
    }
}

extension APIRouter {
/// Parses a HTTP StatusCode and returns a proper error
    /// - Parameter statusCode: HTTP status code
    /// - Returns: Mapped Error
    private func httpError(_ statusCode: Int) -> APIResponseError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 500: return .serverError
        default: return .unknown
        }
    }
    /// Parses URLSession Publisher errors and return proper ones
    /// - Parameter error: URLSession publisher error
    /// - Returns: Readable APIResponseError
    private func handleError(_ error: Error) -> APIResponseError {
        switch error {
        case is Swift.DecodingError:
            return .parsingError
        case let urlError as URLError: do {
            switch urlError.code {
                
            case .notConnectedToInternet:
                return APIResponseError.noInternetConnection
                
            case .timedOut:
                return APIResponseError.requestTimeout
                
            default:
                return APIResponseError.unknown
            }
        }
        case let error as APIResponseError:
            return error
        default:
            return .unknown
        }
    }
}



