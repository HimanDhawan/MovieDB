//
//  LoaderCiew.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/21/23.
//

import SwiftUI

struct CustomLoadingIndicator: View {
    @State private var isAnimating = false
    
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.7)
            .stroke(Color.blue, lineWidth: 5)
            .frame(width: 50, height: 50)
            .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
            .onAppear {
                isAnimating = true
            }
    }
}
