//
//  MovieImage.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/23/24.
//

import Foundation

struct MovieImageResponse: Codable {
    let backdrops: [MovieImage]
}

struct MovieImage: Codable {
    let filePath: String?
    let voteAverage: Float

    var imageURL: URL? {
        if let filepath = filePath {
            return URL(string: "https://image.tmdb.org/t/p/w500" + filepath)
        }
        return nil
    }

    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
        case voteAverage = "vote_average"
    }
}
