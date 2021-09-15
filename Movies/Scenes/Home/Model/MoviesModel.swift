//
//  MoviesModel.swift
//  Movies
//
//  Created by Victor Magnani on 20/07/21.
//

import Foundation

struct MoviesModel: Codable {
    let results: [MoviesResults]
}

struct MoviesResults: Codable {
    let adult: Bool?
    let backdrop_path: String?
    let genre_ids: [Int]
    let id: Int?
    let original_title: String?
    let overview: String?
    let popularity: Double?
    let poster_path: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
}
