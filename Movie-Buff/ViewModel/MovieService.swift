//
//  MovieService.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/18/24.
//

import Foundation
import SwiftUI

class MovieService {

    private let session: URLSession
    private let sessionConfiguration: URLSessionConfiguration
    private let year = Date.now
    private let yearFormat = DateFormatter()
    static let shared = MovieService()

    private var apiKey: String {
        // 1
        guard let filePath = Bundle.main.path(forResource: "tmdb-info", ofType: "plist") else {
            fatalError("Couldn't find file 'tmdb-info.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "Authorization") as? String else {
            fatalError("Couldn't find key 'Authorization' in 'tmdb-info.plist'.")
        }
        // 3
        if value.starts(with: "_") {
            fatalError("Register for a tmdb developer account and get an API key at .")
        }
        return value
    }

    init() {
        self.sessionConfiguration = URLSessionConfiguration.default
        self.session = URLSession(configuration: sessionConfiguration)
    }

    enum LoadMovieDataError: Error {
        case invalidURL
        case invalidResponse
        case invalidData
        case unableToComplete
        case authenticationError
    }

    func loadTrending() async throws -> [Movie] {
        guard let url = URL(string: Constants.URLs.trending) else {
            throw LoadMovieDataError.invalidURL
        }

        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw LoadMovieDataError.invalidResponse
            }

            let decoder = JSONDecoder()
            return try decoder.decode(MovieResponse.self, from: data).results
        } catch {
            throw LoadMovieDataError.invalidData
        }
    }

    func loadUpcomingMovies() async throws -> [Movie] {
        let date = Date.now
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        self.yearFormat.dateFormat = "yyyy"

        // swiftlint:disable:next line_length
        let upcomingMovieURL = Constants.URLs.upcoming + Constants.URLs.releaseDateGTE + dateFormat.string(from: date) + Constants.URLs.releaseDateLTE  + yearFormat.string(from: year) + "-12-31" + Constants.URLs.sortUpcoming + yearFormat.string(from: year)
        guard let url = URL(string: upcomingMovieURL) else {
            throw LoadMovieDataError.invalidURL
        }

        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            return try decoder.decode(MovieResponse.self, from: data).results
        } catch {
            throw LoadMovieDataError.invalidData
        }
    }

    func loadTopRated() async throws -> [Movie] {
        guard let url = URL(string: Constants.URLs.topRated) else {
            throw LoadMovieDataError.invalidURL
        }

        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            return try decoder.decode(MovieResponse.self, from: data).results
        } catch {
            throw LoadMovieDataError.invalidData
        }
    }

    func loadNowPlaying() async throws -> [Movie] {
        guard let url = URL(string: Constants.URLs.nowPlaying) else {
            throw LoadMovieDataError.invalidURL
        }

        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            let decoder = JSONDecoder()
            return try decoder.decode(MovieResponse.self, from: data).results
        } catch {
            throw LoadMovieDataError.invalidData
        }
    }

    func loadBollywood() async throws -> [Movie] {
        self.yearFormat.dateFormat = "yyyy"
        // swiftlint:disable:next line_length
        let bollywoodURL = Constants.URLs.trendBollywood + Constants.URLs.primaryReleaseYearBollywood + yearFormat.string(from: year) +  Constants.URLs.sortBollywood
        guard let url = URL(string: bollywoodURL) else {
            throw LoadMovieDataError.invalidURL
        }

        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            let decoder = JSONDecoder()
            return try decoder.decode(MovieResponse.self, from: data).results
        } catch {
            throw LoadMovieDataError.invalidData
        }
    }

    func loadMovieSearchResults(query: String, page: Int) async throws -> [Movie] {
        // swiftlint:disable:next line_length
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?query=\(query)&include_adult=false&language=en-US&page=\(page)") else {
            throw LoadMovieDataError.invalidURL
        }

        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            let decoder = JSONDecoder()
            return try decoder.decode(MovieResponse.self, from: data).results
        } catch {
            throw LoadMovieDataError.invalidData
        }
    }
}
