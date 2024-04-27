//
//  ActorDetail.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/23/24.
//

import Foundation

struct ActorDetail: Codable, Identifiable {
    let id: Int
    let name: String
    let biography: String?
    let knownForDepartment: String
    let placeOfBirth: String?
    let popularity: Double
    let birthday: String?
    let alsoKnownAs: [String]

    let profilePath: String?
    var profileURL: URL? {
        if let profile = profilePath {
            return URL(string: "https://image.tmdb.org/t/p/w500" + profile)
        }
        return nil
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case biography
        case knownForDepartment = "known_for_department"
        case placeOfBirth = "place_of_birth"
        case popularity
        case birthday
        case alsoKnownAs = "also_known_as"
        case profilePath = "profile_path"
    }
}
