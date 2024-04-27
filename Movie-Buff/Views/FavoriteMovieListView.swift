//
//  FavoriteMovieListView.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/22/24.
//

import SwiftUI
import SwiftData
import CoreData

struct FavoriteMovieListView: View {

    @Environment(\.modelContext) var context
    @Query private var likedMovie: [MovieItem]

    @EnvironmentObject var movieViewModel: MovieViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(likedMovie.filter { $0.tag == "Liked" }) { movie in
                    NavigationLink(destination: MovieDetailView(movie: Movie(id: movie.id,
                                                                             title: movie.title,
                                                                             overview: movie.overview,
                                                                             releaseDate: movie.releaseDate,
                                                                             originalLanguage: movie.originalLanguage,
                                                                             genreIds: movie.genreIds,
                                                                             posterPath: movie.posterPath))) {
                        HStack {
                          //  MovieRemoteImage(urlString: "https://image.tmdb.org/t/p/w500\(movie.poster_path ?? "")")
                            // swiftlint:disable:next line_length
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")"), scale: 4.5)
                                .frame(width: 100, height: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            VStack(alignment: .leading) {
                                Text(movie.title)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                Text("Language: \(movie.originalLanguage.uppercased())")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                Text("Release Date: \(movie.releaseDate)")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                            }.padding(.leading)
                        }
                    }

                }.onDelete { indexSet in
                    for index in indexSet {
                        context.delete(likedMovie[index])
                        try? context.save()
                    }
                }
            }
            .listStyle(.plain)
            .padding(.top)
            .alert(item: $movieViewModel.alertItem) { alert in
                Alert(title: alert.title,
                      message: alert.message,
                      dismissButton: alert.dismissButton)
            }
            .navigationTitle("Favorite Movies")
            .overlay {
                if likedMovie.filter({ $0.tag == "Liked" }).isEmpty {
                    VStack(spacing: 20) {
                        Spacer()
                        Image(systemName: "heart.circle")
                            .font(.system(size: 90, weight: .light))
                            .foregroundStyle(.gray)

                        Spacer()
                    }.opacity(0.7)
                }
            }
        }
    }
}

#Preview {
    FavoriteMovieListView()
        .environment(MovieViewModel())
}
