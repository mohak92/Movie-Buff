//
//  URLUtils.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/18/24.
//

import Foundation

enum Constants {
    enum URLs {
        public static let baseURL = "https://api.themoviedb.org/3"

        // swiftlint:disable:next line_length
        public static let upcoming = baseURL + "/discover/movie?include_adult=false&include_video=false&language=en-US&page=1"
        public static let releaseDateGTE = "&primary_release_date.gte="
        public static let releaseDateLTE = "&primary_release_date.lte="
        public static let sortUpcoming = "&sort_by=popularity.desc&with_release_type=2&year="

        public static let genres = baseURL + "/genre/movie/list?language=en"
        public static let trending = baseURL + "/trending/movie/day?language=en-US"
        public static let topRated = baseURL + "/movie/top_rated?language=en-US&page=1"
        public static let nowPlaying = baseURL + "/movie/now_playing?language=en-US&page=1"

        // swiftlint:disable:next line_length
        public static let trendBollywood = baseURL + "/discover/movie?include_adult=false&include_video=false&language=hi-IN"
        public static let primaryReleaseYearBollywood = "&page=1&primary_release_year="
        public static let sortBollywood = "&sort_by=popularity.desc&with_original_language=hi"

        public static let popularPerson = baseURL + "/person/popular?language=en-US&page=1"
    }
}
