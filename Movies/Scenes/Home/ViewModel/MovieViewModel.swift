//
//  MovieViewModel.swift
//  Movies
//
//  Created by Victor Magnani on 18/08/21.
//

import Foundation

struct MovieViewModel {
    
    var title: String
    var overview: String
    var poster_path: String
    
    //Dependecy Injection
    
    init(movieResult: Result) {
        self.title = movieResult.original_title ?? ""
        self.overview = movieResult.overview ?? ""
        self.poster_path = movieResult.poster_path ?? ""
    }
}
