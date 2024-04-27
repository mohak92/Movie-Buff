//
//  CastMovieCreditsView.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/23/24.
//

import SwiftUI

struct CastMovieCreditsView: View {

    var titleView: String
    var personId: Int
    @EnvironmentObject var viewModel: MovieViewModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(titleView)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.leading, 20)
                Spacer()
                NavigationLink(destination: AllMovieView(movie: viewModel.actorMovieCredits, titleView: titleView)) {
                    Label("See All", systemImage: "arrow.right")
                        .labelStyle(TrailingIconLabelStyle())
                        .font(.footnote)
                        .padding(.trailing, 20)
                        .padding(.top, 10)
                }
            }
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(viewModel.actorMovieCredits) {movie in
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            // swiftlint:disable:next line_length
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")"), scale: 4.5)
                                .frame(width: 110, height: 162.91)
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .scrollTransition { content, phase in
                                    content
                                        .scaleEffect(phase.isIdentity ? 1 : 0.45)
                                        .blur(radius: phase.isIdentity ? 0 : 2.5)
                                }
                                .contextMenu {
                                    ContextMenuMovieCell(movie: movie)
                                }
                        }.buttonStyle(FlatLinkStyle())
                    }
                    .padding(.leading, 15)
                }
                .frame(height: 180)
                .scrollTargetLayout()
            }
            .padding(.top, -10)
            .scrollTargetBehavior(.viewAligned)
            .safeAreaPadding(.horizontal, 10)
        }
        .task {
            viewModel.getActorMovieCredits(personId: personId)
        }
    }
}

#Preview {
    CastMovieCreditsView(titleView: "Movies", personId: 12799)
        .environment(MovieViewModel())
}
