//
//  TabBarItem.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/31/23.
//

import Foundation
import SwiftUI


enum TabBarItem : Hashable {
    case home
    case favourite
    case profile
}
extension TabBarItem {
    var iconName : String {
        switch self {
        case .home:
            return "house"
        case .favourite:
            return "heart"
        case .profile:
            return "person"
        }
    }
    
    var name : String {
        switch self {
        case .home:
            return "Top Movies"
        case .favourite:
            return "Favourite"
        case .profile:
            return "Profile"
        }
    }
    
    var color : Color {
        switch self {
        case .home:
            return .red
        case .favourite:
            return .green
        case .profile:
            return .blue
        }
    }
}

