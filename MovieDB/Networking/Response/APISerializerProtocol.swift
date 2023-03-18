//
//  APISerializerProtocol.swift
//  CustomerPortal
//
//  Created by Nipun Rajput on 04/12/19.
//  Copyright © 2019 Paymentus. All rights reserved.
//

import Foundation


//Not used any more. We use **APIResponse** now with inheritance instead of POP.
/// Set of rules defined for serializing the data returned from an API..
protocol APISerializerProtocol {
    
    associatedtype SerializedModel: Codable
    
    ///A generic data type which will be decided at compile time.
    var serializedData: SerializedModel? { get }
    
    ///Commands the serializaion process. If true, the data returned from the API will be serialized into respective Models..
    var shouldSerialize: Bool { get }
    
    ///Decode/Parse the data from API  into respective Models.
    func serialize(data: Data?, response: URLResponse?, error: Error?, completion: (_ apiResponseError: APIResponseError, _ seializedData: SerializedModel?) -> Void)
}

