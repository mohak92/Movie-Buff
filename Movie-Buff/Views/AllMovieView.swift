//
//  AllMovieView.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/22/24.
//

import SwiftUI

struct AllMovieView: View {

    var movie: [Movie]
    var titleView: String
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(movie) {movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        // swiftlint:disable:next line_length
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")"), scale: 4.5) { phase in
                            if let image = phase.image {
                                image
                            } else {
                                Image("noMoviePoster")
                                    .resizable()
                                    .scaledToFit()
                                    .overlay {
                                        Text(movie.title)
                                            .font(.title2)
                                            .foregroundStyle(.white)
                                    }
                            }
                        }
                        .frame(width: 110, height: 162.91)
                        .scaledToFill()
                        .background(Color(.label))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .scrollTransition { content, phase in
                            content
                                .scaleEffect(phase.isIdentity ? 1 : 0.45)
                                .blur(radius: phase.isIdentity ? 0 : 2.5)
                        }
                        .contextMenu {
                            ContextMenuMovieCell(movie: movie)
                        }
                    }
                    .buttonStyle(FlatLinkStyle())
                }.padding(.vertical, 10)
            }
        }
        .navigationTitle(titleView)
    }
}

#Preview {
    AllMovieView(movie: Mockdata.movielist, titleView: "Trending")
}
