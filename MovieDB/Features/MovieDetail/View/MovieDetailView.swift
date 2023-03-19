//
//  MovieDetailView.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/18/23.
//

import SwiftUI

struct MovieDetailView: View {
    let viewModel : MovieDetailViewModel
    @State var offset : CGFloat = UIScreen.main.bounds.height*0.4
    @State var currentOffset : CGFloat = .zero
    @State var endingOffsetY : CGFloat = .zero
    var body: some View {
        ZStack {
            VStack {
                fullImage
                    .edgesIgnoringSafeArea(.top)
                Spacer()
            }
            MovieDetailBottomView(viewModel: viewModel)
                
                .offset(y: offset)
                .offset(y : currentOffset)
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation(.spring()) {
                                currentOffset = value.translation.height
                            }
                        })
                        .onEnded({ value in
                            
                            withAnimation(.spring()) {
                                if currentOffset < -150 {
                                    endingOffsetY = -offset
                                } else if currentOffset != 0 && currentOffset > 150 {
                                    endingOffsetY = 0
                                }
                                currentOffset = 0
                                
                            }
                        })
                )
        }
        .background(Color.Text.systemWhite)
    }
    var fullImage : some View {
        AsyncImage(url: viewModel.getImageURL()){ image in
                        image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .overlay {
                            Color.black
                                .opacity(0.6)
                        }
                } placeholder: {
                    ProgressView()
                        .tint(Color.Text.systemBlack)
                }
            
            
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(viewModel: .init(movie: .init(id: 123, adult: false, originalTitle: "RRR", overview: "RRR is very good movie", title: "RRR", posterPath: "/ngl2FKBlU4fhbdsrtdom9LVLBXw.jpg", releaseDate: "12-20-23", voteAverage: 2)))
    }
}
