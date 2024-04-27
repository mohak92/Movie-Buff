//
//  MovieDetailView.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/22/24.
//

import SwiftUI

struct MovieDetailView: View {

    @EnvironmentObject var movieViewModel: MovieViewModel
    @State var isRead = false
    var movie: Movie

    var body: some View {
        ZStack(alignment: .bottom) {

            if movieViewModel.isLoading {
                ProgressView {
                    Text("Loading")
                        .foregroundColor(.red)
                        .bold()
                }
            }
            GeometryReader {_ in
                ScrollView {
                    VStack {
                        // swiftlint:disable:next line_length
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFill()
                            } else {
                                Image("noMoviePoster")
                                    .resizable()
                                    .scaledToFill()
                            }
                        }
                        .overlay(content: { LinearPoster() })
                        .background(ScrollViewConfigurator { $0?.bounces = false })

                        VStack(alignment: .leading, spacing: 20) {
                            Text(movieViewModel.movieDetail.title)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal)

                            MovieInfoView(movieDetail: movieViewModel.movieDetail)

                            VStack(alignment: .leading, spacing: 3) {
                                Text(movieViewModel.movieDetail.overview!)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(isRead ? 20 : 3)
                                if movieViewModel.actorDetail.biography?.count ?? 0 < 150 {
                                    Button(isRead ? "Read Less" : "Read More" ) {
                                        isRead.toggle()
                                    }
                                }
                            }
                            .font(.system(size: 16, weight: .regular))
                            // swiftlint:disable:next line_length
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                            .padding()
                            .multilineTextAlignment(.leading)

                            if !movieViewModel.movieCredits.isEmpty {
                                HorizontalScrollCastView(titleView: "Cast", cast: movieViewModel.movieCredits)
                            }
                            if !movieViewModel.movieImage.isEmpty {
                                // MovieImage(movieImage: movieViewModel.movieImage)
                            }
                            if !movieViewModel.movieReview.isEmpty {
                                ReviewsView(movieReview: movieViewModel.movieReview)
                            }
                            if !movieViewModel.movieSimilar.isEmpty {
                                HorizontalScrollView(titleView: "Similar", movieApi: movieViewModel.movieSimilar)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }

                }
                .scrollIndicators(.hidden)
            }
        }
        .task {
            movieViewModel.getMovieDetail(movieID: String(movie.id))
            movieViewModel.getMovieSimilar(movieID: String(movie.id))
            movieViewModel.getMovieCredits(movieID: String(movie.id))
            movieViewModel.movieReview.removeAll()
            movieViewModel.getMovieReview(movieID: String(movie.id))
            movieViewModel.getMovieImage(id: movie.id)
        }
        .ignoresSafeArea(edges: .top)
        .alert(item: $movieViewModel.alertItem) { alert in
            Alert(title: alert.title,
                  message: alert.message,
                  dismissButton: alert.dismissButton)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                LikeButton(movie: movie)
            }
        }
    }
}

#Preview {
    MovieDetailView(movie: Mockdata.sampledata)
        // .environment(\.colorScheme, .dark)
        .environment(MovieViewModel())
}
