//
//  CreateRequestTokenAPIResponse.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/16/23.
//

import Foundation

///Handles Login API response. Notice the overrides to see the manual implementation.
final class CreateRequestTokenAPIResponse: APIResponse {
    
    override func deSerializeWithType() {
        deserialize(model: RequestToken.self)
    }
    
    override func getDeserializedData<RequestToken>() -> RequestToken? {
        return deSerializedData as? RequestToken
    }
}
