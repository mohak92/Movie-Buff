//
//  Cast.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/23/24.
//

import Foundation

struct CreditsResponse: Codable {
    let cast: [Cast]
}

struct Cast: Codable, Identifiable {
    let id: Int
    let name: String
    let originalName: String
    let character: String

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
        case character
        case profilePath = "profile_path"
    }
}
