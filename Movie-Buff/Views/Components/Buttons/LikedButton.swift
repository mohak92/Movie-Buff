//
//  LikedButton.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/24/24.
//

import SwiftUI
import SwiftData

struct LikeButton: View {

    @EnvironmentObject var movieViewModel: MovieViewModel
    @Environment(\.modelContext) var context
    @Query private var likedMovie: [MovieItem]

    @State private var likeClick = false
    @State public var alreadyLike = false

    var movie: Movie

    var body: some View {
        Button(action: {
            if likedMovie.contains(where: { $0.id == movie.id }) {
                if let likedMovieToDelete = likedMovie.first(where: { $0.id == movie.id }) {
                    context.delete(likedMovieToDelete)
                    try? context.save()
                }
                alreadyLike = false
            } else {
                let likedMovie = MovieItem(id: movie.id,
                                            title: movie.title,
                                            overview: movie.overview,
                                            releaseDate: movie.releaseDate,
                                            originalLanguage: movie.originalLanguage,
                                            genreIds: movie.genreIds,
                                            posterPath: movie.posterPath,
                                            posterURL: movie.posterURL,
                                            tag: "Liked")
                context.insert(likedMovie)
                try? context.save()
                alreadyLike = true
            }
        }, label: {
            Circle()
                .fill( alreadyLike ? .white : .clear)
                .strokeBorder(.white, lineWidth: 1)
                .frame(width: 30, height: 30)
                .overlay {
                    Image(systemName: alreadyLike ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(alreadyLike ? .red : .white)
                }
                .tint(alreadyLike ? .red : .gray)
        })
        .task {
            if likedMovie.contains(where: { $0.id == movie.id }) {
                alreadyLike = true
            }
        }
    }
}

struct LikeEffectButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.7 : 1.0)
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
