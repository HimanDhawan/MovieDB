//
//  URLConfig.swift
//  CustomerPortal
//
//  Created by Nipun Rajput on 16/11/19.
//  Copyright © 2019 Paymentus. All rights reserved.
//


import Foundation

///Encapsulates environment and route used to construct a base URL
struct URLConfig {
    
    ///The route/module required for the base URL. For example: https://somebaseURL.com/"<route>"/getData
    var route: String = "3"
    
    ///If you have a "direct URL" which already has the domain/endpoint, set this as true and your "direct URL" will then be used as is.
    var ignoreBaseURL: Bool = false
    
    ///Provides base URL by appending the **environment** and **route** variable
    func baseURL() throws -> URL {
        
        var base = "http://api.themoviedb.org"
        
        if !route.isEmpty {
            base += "/" + route
        }
        
        guard let finalURL = URL(string: base) else {
            throw APIRequestError.invalidURL
        }
        return finalURL
    }
    
    func imageBaseURL(original : Bool = false) throws -> URL {
        var base = "https://image.tmdb.org/t/p/"
        base = base + (!original ? "w185" : "original")
        
        
        
        guard let finalURL = URL(string: base) else {
            throw APIRequestError.invalidURL
        }
        return finalURL
    }
}

