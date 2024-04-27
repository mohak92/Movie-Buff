//
//  MovieService.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/18/24.
//

import Foundation
import SwiftUI

// swiftlint:disable:next type_body_length
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

    func loadMovieDetail(movieID: String) async throws -> MovieDetail {
        // swiftlint:disable:next line_length
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)?append_to_response=results&language=en-US") else {
            throw LoadMovieDataError.invalidURL
        }

        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            let decoder = JSONDecoder()
            return try decoder.decode(MovieDetail.self, from: data)
        } catch {
            throw LoadMovieDataError.invalidData
        }
    }

    func loadGenres() async throws -> [Genre] {
        guard let url = URL(string: Constants.URLs.genres) else {
            throw LoadMovieDataError.invalidURL
        }

        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            let decoder = JSONDecoder()
            return try decoder.decode(GenreListResponse.self, from: data).genres
        } catch {
            throw LoadMovieDataError.invalidData
        }
    }

    func loadMovieByGenre(genreID: String, page: Int) async throws -> [Movie] {
        // swiftlint:disable:next line_length
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=\(page)&sort_by=popularity.desc&with_genres=\(genreID)") else {
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

    func loadMovieSimilar(movieID: String) async throws -> [Movie] {
        // swiftlint:disable:next line_length
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/similar?language=en-US&page=1") else {
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

    func loadCredits(movieID: String) async throws -> [Cast] {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/credits?language=en-US") else {
            throw LoadMovieDataError.invalidURL
        }

        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            let decoder = JSONDecoder()
            return try decoder.decode(CreditsResponse.self, from: data).cast
        } catch {
            throw LoadMovieDataError.invalidData
        }
    }

    func loadCastDetail(castID: String) async throws -> ActorDetail {

        guard let url = URL(string: "https://api.themoviedb.org/3/person/\(castID)?language=en-US") else {
            throw LoadMovieDataError.invalidURL
        }

        var request = URLRequest(url: url)

        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            //            let json = try JSONSerialization.jsonObject(with: data, options: [])
            //            print(json)
            let decoder = JSONDecoder()
            return try decoder.decode(ActorDetail.self, from: data)
        } catch {
            print("Error converting JSON data to object: \(error)")
            throw LoadMovieDataError.invalidData
        }
    }

    func loadCastImages(castID: Int) async throws -> [ActorImage] {
        guard let url = URL(string: "https://api.themoviedb.org/3/person/\(castID)/images") else {
            throw LoadMovieDataError.invalidURL
        }

        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            let decoder = JSONDecoder()
            return try decoder.decode(ActorImageResponse.self, from: data).profiles
        } catch {
            throw LoadMovieDataError.invalidData
        }
    }

    func loadMovieReview(movieID: String) async throws -> [MovieReview] {
        // swiftlint:disable:next line_length
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/reviews?language=en-US&page=1") else {
            throw LoadMovieDataError.invalidURL
        }

        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            let decoder = JSONDecoder()
            return try decoder.decode(MovieReviewResponse.self, from: data).results
        } catch {
            throw LoadMovieDataError.invalidData
        }
    }

    func loadPopularPerson() async throws -> [TrendingActor] {
        guard let url = URL(string: Constants.URLs.popularPerson) else {
            throw LoadMovieDataError.invalidURL
        }

        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            //            let json = try JSONSerialization.jsonObject(with: data, options: [])
            //            print(json)
            let decoder = JSONDecoder()
            return try decoder.decode(TrendingActorResponse.self, from: data).results
        } catch {
            //            print("Error converting JSON data to object: \(error)")
            throw LoadMovieDataError.invalidData
        }
    }

    func loadPersonMovieCredits(personId: Int) async throws -> [Movie] {
        // swiftlint:disable:next line_length
        guard let url = URL(string: "https://api.themoviedb.org/3/person/\(personId)/movie_credits?language=en-US") else {
            throw LoadMovieDataError.invalidURL
        }

        var request = URLRequest(url: url)

        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            let decoder = JSONDecoder()
            return try decoder.decode(ActorMovieCreditsResponse.self, from: data).cast
        } catch {
            throw LoadMovieDataError.invalidData
        }
    }

    func loadMovieImage(id: Int) async throws -> [MovieImage] {

        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/images") else {
            throw LoadMovieDataError.invalidURL
        }

        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            let decoder = JSONDecoder()
            return try decoder.decode(MovieImageResponse.self, from: data).backdrops
        } catch {
            throw LoadMovieDataError.invalidData
        }
    }
}
