//
//  MovieDetailView.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/18/23.
//

import SwiftUI

struct MovieDetailView: View {
    // View Model
    @StateObject var viewModel : MovieDetailViewModel
    
    // Presentation Mode
    @Environment(\.presentationMode) var presentationMode
    
    // Offset for bottom view
    @State var offset : CGFloat = UIScreen.main.bounds.height*0.4
    @State var currentOffset : CGFloat = .zero
    @State var endingOffsetY : CGFloat = .zero
    
    init(movie : Movies, dataService : MovieDetailDataServiceProtocol = MovieDetailDataService() ) {
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel.init(movie: movie, dataService: dataService))
    }
    
    var body: some View {
        ZStack {
            VStack {
                if let image = viewModel.image {
                    if viewModel.isOriginal == false {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay(Material.ultraThin)
                            .edgesIgnoringSafeArea(.top)
                    } else {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay{
                                Color.black
                                    .opacity(0.6)
                            }
                            .edgesIgnoringSafeArea(.top)
                    }
                    
                }
                Spacer()
            }
            
            if viewModel.isOriginal == false {
                ProgressView()
                    .padding(.bottom,100)
                    .tint(Color.Text.systemBlack)
                    
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
                                    endingOffsetY = -offset + UIScreen.main.bounds.height*0.1
                                } else if currentOffset != 0 && currentOffset > 150 {
                                    endingOffsetY = 0
                                }
                                currentOffset = 0
                                
                            }
                        })
                )
        }
        .onAppear{
            Task {
                await self.viewModel.showImage()
            }
        }
        .background(Color.Text.systemWhite)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
        }
    }
    var backButton : some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
            }
        }
        .padding(.top)
    }
}



struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: .init(id: 123, adult: false, originalTitle: "RRR", overview: "RRR is very good movie", title: "RRR", posterPath: "/ngl2FKBlU4fhbdsrtdom9LVLBXw.jpg", releaseDate: "12-20-23", voteAverage: 2))
    }
}
