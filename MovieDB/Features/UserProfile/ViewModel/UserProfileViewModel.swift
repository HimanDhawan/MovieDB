//
//  UserProfileViewModel.swift
//  MovieDB
//
//  Created by Himan Dhawan on 4/1/23.
//

import Foundation


class UserProfileViewModel : ObservableObject {
    
    @Published var pushToFavorite : Bool = false
    
    func pushFavouriteScreen() {
        pushToFavorite = true
    }
    
    func getInitials(from fullName: String) -> String {
        let names = fullName.split(separator: " ")
        if let firstName = names.first, let lastName = names.last {
            let firstInitial = firstName.prefix(1)
            let lastInitial = lastName.prefix(1)
            return "\(firstInitial)\(lastInitial)"
        } else {
            return ""
        }
    }
}
