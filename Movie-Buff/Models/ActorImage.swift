//
//  ActorImage.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/23/24.
//

import Foundation

struct ActorImageResponse: Codable {
    let profiles: [ActorImage]
}

struct ActorImage: Codable {
    let voteAverage: Double

    let filePath: String?
    var imageURL: URL? {
        if let filepath = filePath {
            return URL(string: "https://image.tmdb.org/t/p/w500" + filepath)
        }
        return nil
    }

    enum CodingKeys: String, CodingKey {
        case voteAverage = "vote_average"
        case filePath = "file_path"
    }
}
