//
//  MovieViewModel.swift
//  Movies
//
//  Created by Victor Magnani on 18/08/21.
//

import Foundation

class MovieViewModel {
    
    private static let APIKEY =  "54fdb3ed792cb3dcc5b1aa2c6d87647b"
    private static let basePath = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(APIKEY)")
    
    var movies: MoviesModel? = nil
    var selectedMovie: MoviesResults?
    
    
    func fetchData(success: @escaping() -> (), failure: @escaping(Error) -> ()) {
        Service.request(url: MovieViewModel.basePath, expecting: MoviesModel.self)
        { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                success()
            case .failure(let error):
                print(error)
                failure(error)
            }
        }
    }
}

//Toda VC tem seu proprio viewModel
