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
    @IBOutlet private weak var movieOriginalTitle: UILabel!
    @IBOutlet private weak var movieOverview: UILabel!
    
    var movie: Result!
    
    init(movie: Result){
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
    
    func prepare(){
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(movie?.poster_path ?? "")")
        self.movieBanner.sd_setImage(with: url)
        self.movieOriginalTitle.text = movie?.title ?? ""
        self.movieOverview.text = movie?.overview ?? ""
    }
}
