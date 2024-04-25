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

    @Published var isLoading: Bool = false

    @Published var alertItem: AlertItem?

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
}
