//
//  MovieItem.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/24/24.
//

import Foundation
import SwiftData

@Model
public class MovieItem: Identifiable {
    @Attribute(.unique) public var id: Int
    var title: String
    var overview: String?
    var releaseDate: String
    var originalLanguage: String
    var genreIds: [Int]

    var posterPath: String?
    var posterURL: URL?

    var tag: String

    // swiftlint:disable:next line_length
    init(id: Int, title: String, overview: String? = nil, releaseDate: String, originalLanguage: String, genreIds: [Int], posterPath: String? = nil, posterURL: URL? = nil, tag: String) {
        self.id = id
        self.title = title
        self.overview = overview
        self.releaseDate = releaseDate
        self.originalLanguage = originalLanguage
        self.genreIds = genreIds
        self.posterPath = posterPath
        self.posterURL = posterURL
        self.tag = tag
    }
}
