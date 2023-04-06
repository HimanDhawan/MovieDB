//
//  LoaderCiew.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/21/23.
//

import SwiftUI

struct CustomLoadingIndicator: View {
    @State private var scale: CGFloat = 0
    @State private var opacity: CGFloat = 0
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.black)
                .opacity(opacity)
                .ignoresSafeArea()
                .animation(.easeIn, value: scale)
            
            ZStack {
                Rectangle()
                    .frame(width: 80, height: 80)
                    .foregroundColor(Color.Text.loaderColor)
                    .cornerRadius(10)
                    .shadow(radius: 30)
                    .shadow(color: Color.gray.opacity(0.4), radius: 20, x: 0, y: 10)
                ProgressView()
                    .tint(Color.Text.systemBlack)
            }
            .scaleEffect(scale)
            .animation(.spring(response: 0.5, dampingFraction: 0.7), value: scale)
        }
        .onAppear {
            scale = 1
            withAnimation {
                opacity = 0.3
            }
        }
    }
}

struct LoadingListView: View {
    var body: some View {
        List {
            ForEach(1...6, id : \.self) { _ in
                
                HStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.6))
                        .frame(width: 70,height: 100)
                        .cornerRadius(10)
                        .shimmering()
                    VStack(alignment: .leading, spacing: 15) {
                        Rectangle()
                            .fill(Color.gray.opacity(0.6))
                            .frame(height: 10)
                        Rectangle()
                            .fill(Color.gray.opacity(0.6))
                            .frame(height: 10)
                            .padding(.trailing,90)
                    }
                    .shimmering()
                }
                .padding(.horizontal)
            }
        }
    }
}


struct CustomLoadingIndicator_Previews: PreviewProvider {
    
    static var previews: some View {
        LoadingListView()
    }
}
