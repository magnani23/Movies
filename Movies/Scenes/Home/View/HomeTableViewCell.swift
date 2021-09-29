//
//  HomeTableViewCell.swift
//  Movies
//
//  Created by Victor Magnani on 15/07/21.
//

import UIKit
import SDWebImage

class HomeTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    let movieImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.image = UIImage(named: "John Wick")
        return image
    }()
    
    let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 3
        return label
    }()
    
    let labelsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.setImage(UIImage(systemName: "star"), for: .normal)
        return button
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.prepareLayout()
        self.configViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Methods
    
    private func prepareLayout(){
        self.addSubview(movieImageView)
        self.labelsStackView.addSubview(movieTitleLabel)
        self.labelsStackView.addSubview(overviewLabel)
        self.addSubview(labelsStackView)
        self.addSubview(favoriteButton)
        
    }
    
    private func configViewConstraints(){
        self.setImageConstraints()
        self.setMovieTitleLabelConstraints()
        self.setStackViewConstraints()
        self.setFavoriteButtonConstraints()
        self.setOverviewLabelConstraints()
    }
    
    private func setImageConstraints() {
        self.movieImageView.translatesAutoresizingMaskIntoConstraints = false
        self.movieImageView.centerYAnchor.constraint(equalTo:self.centerYAnchor).isActive = true
        self.movieImageView.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant: 8).isActive = true
        self.movieImageView.widthAnchor.constraint(equalToConstant:72).isActive = true
        self.movieImageView.heightAnchor.constraint(equalToConstant:72).isActive = true
    }
    
    private func setStackViewConstraints() {
        self.labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        self.labelsStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.labelsStackView.leadingAnchor.constraint(equalTo:self.movieImageView.trailingAnchor, constant:8).isActive = true
        self.labelsStackView.trailingAnchor.constraint(equalTo:self.favoriteButton.leadingAnchor, constant: -8).isActive = true
        
    }
    
    private func setMovieTitleLabelConstraints() {
        self.movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.movieTitleLabel.topAnchor.constraint(equalTo:self.labelsStackView.topAnchor).isActive = true
        self.movieTitleLabel.leadingAnchor.constraint(equalTo:self.labelsStackView.leadingAnchor).isActive = true
        self.movieTitleLabel.trailingAnchor.constraint(equalTo:self.labelsStackView.trailingAnchor).isActive = true
        
    }
    
    private func setOverviewLabelConstraints() {
        self.overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        self.overviewLabel.topAnchor.constraint(equalTo:self.movieTitleLabel.bottomAnchor).isActive = true
        self.overviewLabel.leadingAnchor.constraint(equalTo:self.labelsStackView.leadingAnchor).isActive = true
        self.overviewLabel.trailingAnchor.constraint(equalTo: self.labelsStackView.trailingAnchor).isActive = true
    }
    
    private func setFavoriteButtonConstraints() {
        self.favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        self.favoriteButton.widthAnchor.constraint(equalToConstant:24).isActive = true
        self.favoriteButton.heightAnchor.constraint(equalToConstant:24).isActive = true
        self.favoriteButton.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant: -8).isActive = true
        self.favoriteButton.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
    }
    
    func prepare(movie: MoviesResults){
        if let posterPath = movie.poster_path {
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
            self.movieImageView.sd_setImage(with: url)
        }
        
        self.movieTitleLabel.text = movie.title
        self.overviewLabel.text = movie.overview
    }
}
