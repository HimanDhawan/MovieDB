//
//  CastMovieCellViewModel.swift
//  MovieDB
//
//  Created by Himan Dhawan on 3/29/23.
//

import Foundation
import UIKit

class CastMovieCellViewModel : ObservableObject {
    
    let cast : Cast
    let dataService : CastMovieCellDataServiceProtocol
    
    @Published var image : UIImage? = nil
    @Published var error : String? = nil
    
    init(cast: Cast, dataService : CastMovieCellDataServiceProtocol = CastMovieCellDataService()) {
        self.cast = cast
        self.dataService = dataService
    }
        
    func getImageURL() async {
        do {
            await MainActor.run(body: {
                self.error = nil
            })
            let image = try await dataService.getImageURL(cast: self.cast)
            await MainActor.run(body: {
                self.image = image
            })
            
        } catch {
            await MainActor.run(body: {
                self.image = UIImage(systemName: "photo.artframe")
                self.error = error.localizedDescription
            })
            
            print(error)
        }
        
        
    }
    
}
