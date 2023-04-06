//
//  MovieDetailBottomView.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/18/23.
//

import SwiftUI

struct MovieDetailBottomView: View {
    @StateObject var viewModel : MovieDetailViewModel
    @State var selectedMovie : Movies? = nil
            
    var body: some View {
        VStack(){
            Rectangle()
                .frame(width: 40,height: 5)
                .cornerRadius(10)
                
                VStack(alignment:.leading,spacing: -5) {
                    Text(viewModel.movie.title)
                        .font(Font.Heading.medium)
                        .foregroundColor(Color.Text.charcoal)
                        .padding(.leading)
                    ScrollView {
                        VStack(alignment:.leading) {
                            HStack {
                                VStack(alignment:.leading) {
                                    Text("Release date : " + (viewModel.movie.releaseDate ?? "Not mentioned"))
                                        .font(Font.Body.smallSemiBold)
                                        .foregroundColor(Color.Text.grey)
                                        .padding(.leading)
                                    Text("Vote Average : " + (viewModel.movie.voteAverage?.description ?? "Not mentioned"))
                                        .font(Font.Body.smallSemiBold)
                                        .foregroundColor(Color.Text.grey)
                                        .padding(.leading)
                                }
                                Spacer()
                                Button {
                                    print("add to favourite")
                                } label: {
                                    Image(systemName: "heart.fill")
                                        .font(.system(size :20))
                                        .foregroundColor(Color.white)
                                        .background {
                                            Circle()
                                            
                                                .fill(
                                                    LinearGradient(gradient: Gradient(colors: [Color.pink,Color.gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                                )
                                                .frame(width: 45,height: 45)
                                                .shadow(color: Color.Text.charcoal, radius: 6,x: 0,y: 5)
                                        }
                                        .padding(.trailing,30)
                                }
                                
                                Button {
                                    print("add to favourite")
                                } label: {
                                    Image(systemName: "list.bullet.rectangle.fill")
                                        .font(.system(size :20))
                                        .foregroundColor(Color.white)
                                        .background {
                                            Circle()
                                            
                                                .fill(
                                                    LinearGradient(gradient: Gradient(colors: [Color.blue,Color.gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                                )
                                                .frame(width: 45,height: 45)
                                                .shadow(color: Color.Text.charcoal, radius: 6,x: 0,y: 5)
                                        }
                                        .padding(.trailing,30)
                                }
                                
                            }
                            .padding(.top)
                            Text(viewModel.movie.overview)
                                .font(Font.Body.smallDescription)
                                .foregroundColor(Color.Text.grey)
                                .padding()
                            Text("Similar Movies")
                                .padding(.leading)
                                .font(Font.Heading.medium)
                                .foregroundColor(Color.Text.charcoal)
                            
                            if let error = self.viewModel.similarMovieListError  {
                                HStack {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                    Text(error)
                                        .font(Font.Body.smallDescription)
                                        .foregroundColor(Color.Text.grey)
                                }
                                .padding([.bottom,.leading])
                            } else if viewModel.similarMovies.count > 0 {
                                ScrollView(.horizontal,showsIndicators: false) {
                                    LazyHStack {
                                        ForEach(viewModel.similarMovies) { movie in
                                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                                SimilarMovieCellView(viewModel: .init(movie: movie))
                                                    .frame(width:130)
//                                                    .onTapGesture {
//                                                        selectedMovie = movie
//                                                    }
                                            }
                                            
                                        }
                                    }
                                    

                                }
                                
                                
                                .frame(height: 200)
                                .padding([.bottom,.leading])
                            } else {
                                ProgressView()
                            }
                            
                            Text("Cast")
                                .font(Font.Heading.medium)
                                .foregroundColor(Color.Text.charcoal)
                                .padding(.leading)
                            
                            if let error = self.viewModel.castListError  {
                                HStack {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                    Text(error)
                                        .font(Font.Body.smallDescription)
                                        .foregroundColor(Color.Text.grey)
                                }
                                .padding()
                            } else if viewModel.cast.count > 0 {
                                ScrollView(.horizontal,showsIndicators: false) {
                                    LazyHStack {
                                        ForEach(viewModel.cast) { cast in
                                            CastMovieCellView(viewModel: .init(cast: cast))
                                                .frame(width:120)
                                            
                                        }
                                    }
                                }
                                .frame(height: 170)
                                .padding(.leading)
                            } else {
                                ProgressView()
                            }
                            
                            
                            Spacer(minLength: 80)
                        }
                        
                        
                    }
                }
        }
        .preference(key: SimilarMovieSelectionPreferenceKey.self,value : self.selectedMovie)
        .frame(maxWidth: .infinity)
        .padding(.top,10)
        .background(Color.Text.systemBlack)
        .cornerRadius(20)
        .onAppear{
            print("onAppear bottom")
            Task {
                await self.viewModel.getSimilarMovies()
            }
            Task {
                await self.viewModel.getCasts()
            }
        }
    }
}

struct MovieDetailBottomView_Previews: PreviewProvider {
    @State static var movieDetailScroll : CGPoint = .zero
    static var previews: some View {
        NavigationView {
            MovieDetailBottomView(viewModel: .init(movie: .init(id: 123, adult: false, originalTitle: "RRR", overview: "RRR is very good movie", title: "RRR", posterPath: "/ngl2FKBlU4fhbdsrtdom9LVLBXw.jpg", releaseDate: "12-20-23", voteAverage: 2), dataService: MovieDetailDataService()))

        }
    }
}
