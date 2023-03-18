//
//  ErrorDataProtocol.swift
//  CustomerPortal
//
//  Created by Nipun Rajput on 20/11/19.
//  Copyright © 2019 Paymentus. All rights reserved.
//

import Foundation

///Set of rules declared for a custom error during a network request. If your netwrok related error provides a key value pair information, you should adopt this.
protocol ErrorDataProtocol {
    
    var errorDictionary: [String: Any]? { get }
}


///Extension for providing default implementation to **ErrorDataProtocol**.
extension ErrorDataProtocol {
    
    var errorDictionary: [String: Any]? {
        get {
            return nil
        }
    }
}
