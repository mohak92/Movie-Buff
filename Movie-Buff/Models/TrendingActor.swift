//
//  TrendingActor.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/23/24.
//

import Foundation

struct TrendingActorResponse: Codable {
    let results: [TrendingActor]
}

struct ActorMovieCreditsResponse: Codable {
    let cast: [Movie]
}

struct TrendingActor: Codable, Identifiable {
    let id: Int
    let name: String
    let originalName: String
    let knownForDepartment: String?
    let popularity: Double

    let profilePath: String?
    var profileURL: URL? {
        if let poster = profilePath {
            return URL(string: "https://image.tmdb.org/t/p/w500" + poster)
        }
        return nil
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case originalName = "original_name"
        case knownForDepartment = "known_for_department"
        case popularity
        case profilePath = "profile_path"
    }
}
