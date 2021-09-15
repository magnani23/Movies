//
//  MovieViewModel.swift
//  Movies
//
//  Created by Victor Magnani on 18/08/21.
//

import Foundation

class MovieViewModel {
    
    var movies: MoviesModel?
    var selectedMovie: Result?
    
    
    func fetchData(success: @escaping() -> (), failure: @escaping(MovieError) -> ()) {
        Service.loadMovies { (movies) in
            self.movies = movies
            success()
        } onError: { (error) in
            failure(error)
        }
    }
}

//Toda VC tem seu proprio viewModel
