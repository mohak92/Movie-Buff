//
//  MovieDetail.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/23/24.
//

import Foundation

struct MovieDetailResponse: Codable {
    let results: MovieDetail
}

struct MovieDetail: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String?
    let releaseDate: String
    let originalLanguage: String
    let budget: Int
    let revenue: Int
    let runtime: Int
    let status: String
    let voteAverage: Double
    let posterPath: String?
    var posterURL: URL? {
        if let poster = posterPath {
            return URL(string: "https://image.tmdb.org/t/p/w500" + poster)
        }
        return nil
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case budget
        case revenue
        case runtime
        case status
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
}
