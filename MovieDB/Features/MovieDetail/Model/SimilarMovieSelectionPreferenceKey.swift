//
//  SimilarMovieSelectionPreferenceKey.swift
//  MovieDB
//
//  Created by Himan Dhawan on 4/3/23.
//

import Foundation
import SwiftUI

class SimilarMovieSelectionPreferenceKey : PreferenceKey {
    static var defaultValue: Movies? = nil
    
    static func reduce(value: inout Movies?, nextValue: () -> Movies?) {
        value = nextValue()
    }
}

extension View {
    func selectMovie(movie : Movies) -> some View {
        self.preference(key: SimilarMovieSelectionPreferenceKey.self,value: movie)
    }
}

