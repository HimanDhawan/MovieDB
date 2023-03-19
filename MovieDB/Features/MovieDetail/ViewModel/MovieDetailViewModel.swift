//
//  MovieDetailViewModel.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/18/23.
//

import Foundation
import Combine

class MovieDetailViewModel : ObservableObject {
    let movie : Movies
    let apiRouter = APIRouter<MoviesAPIRequest>()
    @Published var similarMovies : [Movies] = []
    let token = "076c9dad29e213f91dbbe7a82aa1da1d"
    var anyCancelabels : Set<AnyCancellable> = []
    init(movie: Movies) {
        self.movie = movie
    }
    
    func getImageURL() -> URL? {
        guard let urlString = try? URLConfig().imageBaseURL(original: true).absoluteString, let posterPath = movie.posterPath else {
            return nil
        }
        print("urlString + posterPath \(urlString + posterPath)")
        return URL(string: urlString + posterPath)
    }
    func getSimilarMovies() {
        let publisher : AnyPublisher<MovieResultData,Error> = apiRouter.request(.similarMovies(apiKey: token, movieID: movie.id.description))
        publisher
            .sink { completion in
                switch completion {
                case .finished: print("Finished")
                case .failure(let error): print("Error \(error)")
                    
                }
            } receiveValue: { movies in
                print(movies)
                self.similarMovies = movies.results
                
            }
            .store(in: &anyCancelabels)

    }
}


