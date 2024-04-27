//
//  MovieReview.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/23/24.
//

import Foundation

struct MovieReviewResponse: Codable {
    let results: [MovieReview]
}

struct MovieReview: Codable {
    let author: String
    let authorDetails: AuthorDetails
    let content: String

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
    }
}

struct AuthorDetails: Codable, Hashable {
    let name: String
    let username: String
    let avatarPath: String?

    enum CodingKeys: String, CodingKey {
        case name
        case username
        case avatarPath = "avatar_path"
    }
}
