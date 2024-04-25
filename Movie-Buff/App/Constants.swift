//
//  URLUtils.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/22/24.
//

import Foundation

enum Urls {
    static let baseURL = "https://api.themoviedb.org/3"
    static let upcomingED = baseURL + "/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&primary_release_date.gte=2024-02-17&primary_release_date.lte=2024-12-31&sort_by=popularity.desc&with_release_type=2&year=2024"
    static let genresED = baseURL + "/genre/movie/list?language=en"
    static let trendingED = baseURL + "/trending/movie/day?language=en-US"
    static let topRatedED = baseURL + "/movie/top_rated?language=en-US&page=1"
    static let nowPlayingED = baseURL + "/movie/now_playing?language=en-US&page=1"
    static let trendThai = baseURL + "/discover/movie?include_adult=false&include_video=false&language=hi-IN&page=1&primary_release_year=2024&sort_by=popularity.desc&with_original_language=hi"
    static let popularPerson = baseURL + "/person/popular?language=en-US&page=1"
}
