//
//  APIRouter.swift
//  CustomerPortal
//
//  Created by Nipun Rajput on 19/11/19.
//  Copyright © 2019 Paymentus. All rights reserved.
//

import Foundation
import Combine

// Using combine
///Handles routing of a requests based on the specified generic types named **Request** and **Response**, which should adopt **APIRequestProtocol** and inherit from**APIResponse** respectively. Also, adopts **NetworkRouterProtocol** to the routing.
class APIRouter<Request: APIRequestProtocol>: NetworkRouterProtocol {
    
    func request<T>(_ route: Request) -> AnyPublisher<T, Error> where T : Decodable, T : Encodable {
        do {
            let request = try RequestBuilder<Request>().buildRequest(from: route)
            
            
            APINetworkLogger.log(request: request)
            
            return URLSession.shared
                .dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                // Map on Request response
                .tryMap({ data, response in
                    // If the response is invalid, throw an error
                    print(response)
                    if let response = response as? HTTPURLResponse,
                       !(200...299).contains(response.statusCode) {
                        throw self.httpError(response.statusCode)
                    }
                    // Return Response data
                    return data
                })
                // Decode data using our ReturnType
                .decode(type: T.self, decoder: JSONDecoder())
    //            // Handle any decoding errors
                .mapError { error in
                    print(error)
                    return self.handleError(error)
                }
                // And finally, expose our publisher
                .eraseToAnyPublisher()
        } catch {
            return Just(Result<String, Error>.failure(error))
                .setFailureType(to: Error.self)
                .tryMap { result in
                    throw error
                }
                .eraseToAnyPublisher()
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


class APIRouter1<Request: APIRequestProtocol, Response: APIResponse>: NetworkRouterProtocol1 {
    private var task: URLSessionTask?
    
    ///Triggers the **Request**
    func request(_ route: Request, completion: @escaping (Response) -> Void) {
        
        let session = URLSession.shared
        
        do {
            let request = try RequestBuilder<Request>().buildRequest(from: route)
            
            APINetworkLogger.log(request: request)
            
            task = session.dataTask(with: request, completionHandler: {(data, response, httpError) in
                
                ///Creates **Response** object based on the generic type sent in this method.
                let apiResponse = Response.init(data: data, response: response, error: httpError)
                
                completion(apiResponse)
            })
            
        } catch {
            ///Error while building the request. Use the convenience init of **Response** to setup a custom error message.
            let apiResponse = Response.init(withOnly: APIResponseError.customMessage(error.localizedDescription))
            
            completion(apiResponse)
        }
        
        self.task?.resume()
    }
    
    ///Cancels a **Request**
    func cancel() {
        self.task?.cancel()
    }
}

class APIRouter3<Request: APIRequestProtocol, Response: APIResponse> {
    private var task: URLSessionTask?
    
    ///Triggers the **Request**
    func request(_ route: Request) async throws -> Response? {
                
        do {
            let request = try RequestBuilder<Request>().buildRequest(from: route)
            
            APINetworkLogger.log(request: request)
            
            let (data,response) = try await URLSession.shared.data(for: request)
            
            return Response.init(data: data, response: response, error: nil)
            
        } catch {
            
            throw error
        }
        
        
    }
    
    ///Cancels a **Request**
    func cancel() {
        self.task?.cancel()
    }
}




