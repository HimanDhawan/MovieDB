//
//  Font.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/18/23.
//

import SwiftUI
import UIKit

extension Font {
    
    enum Heading {
        static var medium: Font = Font.custom("Poppins-SemiBold", size: 23)
        static var small: Font = Font.custom("Poppins-SemiBold", size: 22)
    }
    
    enum Body {
        static var small: Font = Font.custom("Poppins-Regular", size: 14)
        static var smallSemiBold: Font = Font.custom("Poppins-SemiBold", size: 14)
        static var smallDescription: Font = Font.custom("Poppins-Regular", size: 12)
    }
   
}
