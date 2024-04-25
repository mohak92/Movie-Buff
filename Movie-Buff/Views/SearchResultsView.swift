//
//  SearchResultsView.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/23/24.
//

import SwiftUI

struct SearchResultsView: View {

    enum FocusedField {
        case search
    }

    @EnvironmentObject var movieViewModel: MovieViewModel
    @State var searchText = ""
    @FocusState var isFocus: FocusedField?
    @Binding var isInSearch: Bool

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            TextField("Search", text: $searchText)
                .onSubmit {
                    movieViewModel.searchMovie.removeAll()
                    movieViewModel.getMovieSearchResults(query: searchText, page: 1)
                    movieViewModel.getMovieSearchResults(query: searchText, page: 2)
                    movieViewModel.getMovieSearchResults(query: searchText, page: 3)
                }
                .focused($isFocus, equals: .search)
                .textFieldStyle(.roundedBorder)
                .padding()
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(movieViewModel.searchMovie) {movie in
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            // swiftlint:disable:next line_length
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")"), scale: 4.5) { phase in
                                if let image = phase.image {
                                    image
                                } else {
                                    Image("noMoviePoster").resizable()
                                }
                            }
                            .frame(width: 110, height: 162.91)
                            .scaledToFill()
                            .background(Color(.label))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .contextMenu {
                                ContextMenuMovieCell(movie: movie)
                            }
                        }
                        .buttonStyle(FlatLinkStyle())
                    }.padding(.vertical, 10)
                }
            }
            .scrollIndicators(.hidden)
            .overlay {
                if movieViewModel.searchMovie.isEmpty {
                    VStack(spacing: 20) {
                        Spacer()
                        Image(systemName: "text.magnifyingglass")
                            .font(.system(size: 90, weight: .light))
                            .foregroundStyle(.gray)
                        Spacer()
                    }.opacity(0.7)
                }
            }
        }
        .navigationTitle("Search")
        .onAppear(perform: {
            movieViewModel.searchMovie.removeAll()
            isFocus = .search
        })
        .alert(item: $movieViewModel.alertItem) { alert in
            Alert(title: alert.title,
                  message: alert.message,
                  dismissButton: alert.dismissButton)
        }

    }
}
