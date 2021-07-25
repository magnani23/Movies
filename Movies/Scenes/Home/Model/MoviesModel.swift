//
//  MoviesModel.swift
//  Movies
//
//  Created by Victor Magnani on 20/07/21.
//

import Foundation

struct MoviesModel: Codable {
    let results: [Result]
}

struct Result: Codable {
    let adult: Bool?
    let backdrop_path: String?
    let genre_ids: [Int]
    let id: Int?
    let original_title, overview: String?
    let popularity: Double?
    let poster_path, releaseDate, title: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
}
