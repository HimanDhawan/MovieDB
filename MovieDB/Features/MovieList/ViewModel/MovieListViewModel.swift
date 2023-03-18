//
//  MovieListViewModel.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/14/23.
//

import Foundation
import Combine

class MovieListViewModel : ObservableObject {
    @Published var movies : [Movies] = []
    @Published var moviesCount : String = "0"
    
    @Published var selectedMovie: Movies? = nil
    @Published var isSelected: Bool = false
    
    let token = "076c9dad29e213f91dbbe7a82aa1da1d"
    
    let apiRouter = APIRouter<MoviesAPIRequest>()
    var anyCancelabels : Set<AnyCancellable> = []
    
    init() {

    }
    
    func getAllPopularMovies() {
        let publisher : AnyPublisher<MovieResultData,Error> = apiRouter.request(.getMovies(apiKey: token))
        publisher
            
            .sink { completion in
                switch completion {
                case .finished: print("Finished")
                case .failure(let error): print("Error \(error)")
                    
                }
            } receiveValue: { movies in
                print(movies)
                self.movies = movies.results
                self.moviesCount = movies.results.count.description
                
            }
            .store(in: &anyCancelabels)

    }
    
}
