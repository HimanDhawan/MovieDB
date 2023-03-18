//
//  ServerResponseProtocol.swift
//  CustomerPortal
//
//  Created by Nipun Rajput on 18/11/19.
//  Copyright © 2019 Paymentus. All rights reserved.
//

import Foundation


//Not used any more. We use **APIResponse** now with inheritance instead of POP.
//Keeping in the code for reference.

///Set of rules declared for an API response. Every API response should confirm to this protocol. When you adopt this protocol make sure to satisfy **data**, **response** and **error** as "constants"(let) instead of variables to make them read-only.
protocol APIResponseProtocol: APISerializerProtocol {
    
    ///Associates this protocol with a generic type **Model** to satisfy the **serializedData** variable.
    associatedtype Model: Codable
    
    ///Data sent from server
    var data: Data? { get }
    
    ///URLReponse from server
    var response: URLResponse? { get }
    
    ///Error caught while making a request via URLSession.
    var httpError: Error? { get }
    
    ///Tracks the specific error for an **APIResponseProtocol**
    var apiResponseError: APIResponseError { get set }
    
    ///Protocol requirement init method, to initialize the variables.
    init(data: Data?, response: URLResponse?, error: Error?)
    
    ///Used as a convenience init to setup all the variables as nil and with a custom **APIResponseError**
    init(withOnly apiResponseError: APIResponseError)
    
    ///Validates if the reponse code is in between 200...299. Implement this method in specific adoption of this protocol to change its definition.
    func validateStatusCode() -> Bool
}


///Extension for providing default implementation to **APIResponseProtocol**.
extension APIResponseProtocol {
    
    ///Default implementation to check if the status code is in between 200 and 299.
    func validateStatusCode() -> Bool {
        
        guard let response = response else {
            return false
        }
        
        if let response = response as? HTTPURLResponse {
            
            return (200...299).contains(response.statusCode)
            
        } else {
            
            return false
        }
    }
    
    ///Default implementation of the **serialize** method to support similar decocing and parsing of API response data. If you feel that a certain API has its own conditions to decode/parse, you can implement your own serialize method when you adopt **APIResponseProtocol**
    func serialize (data: Data?, response: URLResponse?, error: Error?, completion: (_ apiResponseError: APIResponseError, _ seializedData: Model?) -> Void) {

        if self.validateStatusCode() {

            guard let data = data else {

                completion(APIResponseError.parsingError, nil)

                return
            }

            do {

                let modelData = try JSONDecoder().decode(Model.self, from: data)
                
                completion(APIResponseError.none, modelData)

            } catch {

                guard let errorDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {

                    completion(APIResponseError.unknown, nil)

                    return
                }

                completion(APIResponseError.customDictionary(errorDictionary), nil)
            }

        } else {

            completion(APIResponseError.incorrectStatusCode, nil)
        }
    }
}

