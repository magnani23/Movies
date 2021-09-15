//
//  MoviesViewController.swift
//  Movies
//
//  Created by Victor Hugo Bernardino Magnani on 20/07/21.
//

import UIKit
import SDWebImage

class MoviesViewController: UIViewController {
    
    @IBOutlet private weak var movieBanner: UIImageView!
    @IBOutlet private weak var movieOverview: UILabel!
    
    private var movie: MovieViewModel
    
    init(movie: MovieViewModel){
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepare()
    }
    
    private func prepare(){
        if let posterPath = movie.selectedMovie?.poster_path {
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
            self.movieBanner.sd_setImage(with: url)
        }
        self.movieOverview.text = movie.selectedMovie?.overview
    }
}
