//
//  MoviesList.swift
//  MovieList
//
//  Created by Son Vu on 10/09/2023.
//

import Foundation

struct MoviesList: Codable {
    var listMovie: [MovieItem]
    
    enum CodingKeys: String, CodingKey {
        case listMovie = "movieList"
    }
}

struct MovieItem: Codable {
    var title: String
    var description: String
    var rating: Double
    var duration: String
    var genre: String
    var releasedDate: String
    var trailerLink: String
    var poster: String
    var isOnWatchList: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case rating
        case duration
        case genre
        case releasedDate
        case trailerLink
        case poster
    }
}
