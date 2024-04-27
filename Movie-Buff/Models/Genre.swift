//
//  Genre.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/23/24.
//

import Foundation

struct GenreListResponse: Codable {
    let genres: [Genre]
}

struct Genre: Codable, Identifiable {
    let id: Int
    let name: String
}
