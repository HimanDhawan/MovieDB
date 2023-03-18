//
//  APIResponse.swift
//  CustomerPortal
//
//  Created by Nipun Rajput on 10/12/19.
//  Copyright © 2019 Paymentus. All rights reserved.
//

import Foundation

/// Superclass designated for handling the response of all the APIs
class APIResponse {
    
    ///Data sent from server
    var data: Data?
    
    ///URLReponse from server
    var response: URLResponse?
    
    ///Error caught while making a request via URLSession
    var httpError: Error?
    
    ///Tracks the specific error for an **APIResponse**
    var apiResponseError: APIResponseError = .none
    
    ///Will store the Data coming from an API into a specific model object provided by the target subclass overriding this class. If you need that data with the targeted data type, use the overriden **getDeserializedData** method
    var deSerializedData: Codable?

    ///Commands the serializaion process. If true, the data returned from the API will be serialized into respective Models. Its true by default, but you can change it while calling the init method
    var needsDeserialization: Bool = true
    
    // MARK: - Init
    
    ///Inits and deserializes data in the URLRequest response to targeted model objects.
    /// - Parameters:
    ///   - shouldDeserialize: Set this to false, if you don't need the deserialization
    required init(data: Data?, response: URLResponse?, error: Error?, shouldDeserialize: Bool = true) {
        self.data = data
        
        self.response = response
        
        self.httpError = error
        
        self.needsDeserialization = shouldDeserialize
        
        if self.needsDeserialization {
            
            deSerializeWithType()
            
        } else {
            
            evaluateResponseWithoutDeserialization()
        }
    }
    
    ///Used as a convenience init to setup all the variables as nil and with a custom **APIResponseError**
    convenience required init(withOnly apiResponseError: APIResponseError) {
        self.init(data: nil, response: nil, error: nil, shouldDeserialize: false)
        
        self.apiResponseError = apiResponseError
    }
    
    // MARK: - Override Qualifiers
    
    ///Override this if you want the deserialization of your data coming from URLRequest. Should be overriden especially when **shouldDeserialize** is sent as true in the init method. 
    func deSerializeWithType() {
        fatalError("Must overrride this method to trigger the deserialization with custom model type")
    }
    
    ///Override this if you want the type safe deserialized data of your choice
    func getDeserializedData<T>() -> T? {
        fatalError("Must overrride this method to return a custom model type, deserialized data")
    }
    
    // MARK: - Public Access
    
    ///Validates if the reponse code is in between 200...299. Implement this method in specific inherited subclass to change its definition.
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
    
    ///Parses and Decodes data from an API. If you feel that a certain API has its own conditions to decode/parse, you can override and implement your own serialize method
    /// - Parameters:
    ///   - model: The "Type" of an entitiy/model which should confirm to Codable
    func deserialize<T> (model: T.Type) where T: Codable {

        if self.validateStatusCode() {

            guard let data = data else {

                self.apiResponseError = APIResponseError.parsingError
                
                return
            }

            do {

                self.deSerializedData = try JSONDecoder().decode(model, from: data)

            } catch {

                let jsonResponse = String(decoding: data, as: UTF8.self)
                
                print("Faulty JSON - URL: \n" + (response?.url?.absoluteString ?? ""))
                
                print("Response: \n" + jsonResponse)
                
                print("Deserialize error: \(error)")
                
                guard let errorDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {

                    self.apiResponseError = APIResponseError.unknown

                    return
                }

                self.apiResponseError = APIResponseError.customDictionary(errorDictionary)
            }

        } else {
            
            setErrorFrom(httpError: httpError, response: response)
        }
    }
    
    ///Some APIs do not need to be desrialized into models. For them we will only update the error codes and use the JSON-string/Dictionary in viewModels.
    func evaluateResponseWithoutDeserialization() {
        
        if self.validateStatusCode() {
            
            guard data != nil else {
                
                self.apiResponseError = APIResponseError.parsingError
                
                return
            }
            
        } else {
            
            setErrorFrom(httpError: httpError, response: response)
        }
    }
    
    ///Sets up errors from Error and URLResponse returned from an API call
    func setErrorFrom(httpError: Error?, response: URLResponse?) {

        //Check for "no internet error"
        if let error = httpError as? URLError {
            
            switch error.code {
                
            case .notConnectedToInternet:
                self.apiResponseError = APIResponseError.noInternetConnection
                
            case .timedOut:
                self.apiResponseError = APIResponseError.requestTimeout
                
            default:
                self.apiResponseError = APIResponseError.unknown
            }
            
        } else {
            
            if let response = self.response as? HTTPURLResponse {
              
                if response.statusCode == 401 || response.statusCode == 520 || response.statusCode == 521 || response.statusCode == 522 {
                    
                    print("Server Issue - URL: " + (response.url?.absoluteString ?? ""))
                    
                    self.apiResponseError = APIResponseError.unauthorized
                    
                    
                } else {
                    
                    print(" Incorrect HTTP status code - URL: " + (response.url?.absoluteString ?? ""))
                    
                    self.apiResponseError = APIResponseError.customMessage("Incorrect HTTP status code: " + "\(response.statusCode)")
                }
                
            } else {
                
                self.apiResponseError = APIResponseError.unknown
            }
        }
    }
}
