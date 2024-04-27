//
//  MovieViewModel.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/18/24.
//

import SwiftUI

@MainActor
final class MovieViewModel: ObservableObject, Observable {
    @Published var upComingMovie: [Movie] = []
    @Published var trendingMovie: [Movie] = []
    @Published var topRatedMovie: [Movie] = []
    @Published var nowPlaying: [Movie] = []
    @Published var searchMovie: [Movie] = []
    @Published var trendingBollywood: [Movie] = []

    @Published var genre: [Genre] = []
    @Published var movieByGenre: [Movie] = []

    @Published var movieDetail: MovieDetail = Mockdata.movieDetailsample
    @Published var movieSimilar: [Movie] = []
    @Published var movieReview: [MovieReview] = []
    @Published var movieImage: [MovieImage] = []
    @Published var movieCredits: [Cast] = []

    @Published var cast: [Cast] = []
    @Published var actorDetail: ActorDetail = Mockdata.actorDetailSample
    @Published var actorImage: [ActorImage] = []
    @Published var trendingActor: [TrendingActor] = []
    @Published var actorMovieCredits: [Movie] = []

    @Published var isLoading: Bool = false

    @Published var alertItem: AlertItem?

    @Published var likedMovies: [MovieItem] = []

    func getUpcomingMovie() {
        isLoading = true
        Task {
            do {
                upComingMovie = try await MovieService.shared.loadUpcomingMovies()
                isLoading = false
            } catch {
                alertItem = AlertMessage.GeneralError
                isLoading = false
            }
        }
    }

    func getTrendingMovie() {
        isLoading = true
        Task {
            do {
                trendingMovie = try await MovieService.shared.loadTrending()
                isLoading = false
            } catch {
                alertItem = AlertMessage.GeneralError
                isLoading = false
            }
        }
    }

    func getTopRated() {
        isLoading = true
        Task {
            do {
                topRatedMovie = try await MovieService.shared.loadTopRated()
                isLoading = false
            } catch {
                alertItem = AlertMessage.GeneralError
                isLoading = false
            }
        }
    }

    func getNowPlaying() {
        isLoading = true
        Task {
            do {
                nowPlaying = try await MovieService.shared.loadNowPlaying()
                isLoading = false
            } catch {
                alertItem = AlertMessage.GeneralError
                isLoading = false
            }
        }
    }

    func getBollywood() {
        isLoading = true
        Task {
            do {
                trendingBollywood = try await MovieService.shared.loadBollywood()
                isLoading = false
            } catch {
                alertItem = AlertMessage.GeneralError
                isLoading = false
            }
        }
    }

    func getMovieSearchResults(query: String, page: Int) {
        isLoading = true
        Task {
            do {
                // swiftlint:disable:next line_length
                searchMovie.append(contentsOf: try await MovieService.shared.loadMovieSearchResults(query: query, page: page))
                isLoading = false
            } catch {
                alertItem = AlertMessage.GeneralError
                isLoading = false
            }
        }
    }

    func getMovieDetail(movieID: String) {
        isLoading = true
        Task {
            do {
                movieDetail = try await MovieService.shared.loadMovieDetail(movieID: movieID)
                isLoading = false
            } catch {
                alertItem = AlertMessage.GeneralError
                isLoading = false
            }
        }
    }

    func getGenre() {
        isLoading = true
        Task {
            do {
                genre = try await MovieService.shared.loadGenres()
                isLoading = false
            } catch {
                alertItem = AlertMessage.GeneralError
                isLoading = false
            }
        }
    }

    func getMovieByGenre(genreID: String, page: Int) {
        isLoading = true
        Task {
            do {
                // swiftlint:disable:next line_length
                movieByGenre.append(contentsOf: try await MovieService.shared.loadMovieByGenre(genreID: genreID, page: page))
                isLoading = false
            } catch {
                alertItem = AlertMessage.GeneralError
                isLoading = false
            }
        }
    }

    func getMovieSimilar(movieID: String) {
        isLoading = true
        Task {
            do {
                movieSimilar = try await MovieService.shared.loadMovieSimilar(movieID: movieID)
                isLoading = false
            } catch {
                alertItem = AlertMessage.GeneralError
                isLoading = false
            }
        }
    }

    func getMovieCredits(movieID: String) {
        isLoading = true
        Task {
            do {
                movieCredits = try await MovieService.shared.loadCredits(movieID: movieID)
                isLoading = false
            } catch {
                alertItem = AlertMessage.GeneralError
                isLoading = false
            }
        }
    }

    func getCastDetail(cast: String) {
        isLoading = true
        Task {
            do {
                actorDetail = try await MovieService.shared.loadCastDetail(castID: cast)
                isLoading = false
            } catch {
                alertItem = AlertMessage.GeneralError
                isLoading = false
            }
        }
    }

    func getCastImages(cast: Int) {
        isLoading = true
        Task {
            do {
                actorImage = try await MovieService.shared.loadCastImages(castID: cast)
                isLoading = false
            } catch {
                alertItem = AlertMessage.GeneralError
                isLoading = false
            }
        }
    }

    func getMovieReview(movieID: String) {
        isLoading = true
        Task {
            do {
                movieReview = try await MovieService.shared.loadMovieReview(movieID: movieID)
                isLoading = false
            } catch {
                alertItem = AlertMessage.GeneralError
                isLoading = false
            }
        }
    }

    func getTrendingActor() {
        isLoading = true
        Task {
            do {
                trendingActor = try await MovieService.shared.loadPopularPerson()
                isLoading = false
            } catch {
                alertItem = AlertMessage.GeneralError
                isLoading = false
            }
        }
    }

    func getActorMovieCredits(personId: Int) {
        isLoading = true
        Task {
            do {
                actorMovieCredits = try await MovieService.shared.loadPersonMovieCredits(personId: personId)
                isLoading = false
            } catch {
                alertItem = AlertMessage.GeneralError
                isLoading = false
            }
        }
    }

    func getMovieImage(id: Int) {
        isLoading = true
        Task {
            do {
                movieImage = try await MovieService.shared.loadMovieImage(id: id)
                isLoading = false
            } catch {
                alertItem = AlertMessage.GeneralError
                isLoading = false
            }
        }
    }
}
