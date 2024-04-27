//
//  Movie.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/18/24.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable, Identifiable, Hashable {

    var id: Int
    var title: String
    var overview: String?
    var releaseDate: String
    var originalLanguage: String
    var genreIds: [Int]
    var posterPath: String?
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
        case genreIds = "genre_ids"
        case posterPath = "poster_path"
    }
}

struct Mockdata {
    // swiftlint:disable:next line_length
    static let sampledata = Movie(id: 0, title: "", overview: "", releaseDate: "", originalLanguage: "", genreIds: [0], posterPath: "")

    static let movielist = [
        Movie(id: 0, title: "", overview: "", releaseDate: "", originalLanguage: "", genreIds: [0], posterPath: ""),
        Movie(id: 1, title: "", overview: "", releaseDate: "", originalLanguage: "", genreIds: [0], posterPath: ""),
        Movie(id: 2, title: "", overview: "", releaseDate: "", originalLanguage: "", genreIds: [0], posterPath: ""),
        Movie(id: 3, title: "", overview: "", releaseDate: "", originalLanguage: "", genreIds: [0], posterPath: "")
    ]

    static let movieDetailsample = MovieDetail(id: 0,
                                               title: "",
                                               overview: "",
                                               releaseDate: "",
                                               originalLanguage: "",
                                               budget: 0,
                                               revenue: 0,
                                               runtime: 0,
                                               status: "",
                                               voteAverage: 0,
                                               posterPath: "")

    static let actorDetailSample = ActorDetail(id: 0,
                                             name: "",
                                             biography: "",
                                             knownForDepartment: "",
                                             placeOfBirth: "",
                                             popularity: 0,
                                             birthday: "",
                                             alsoKnownAs: [
                                                ""
                                              ],
                                             profilePath: "")
}
