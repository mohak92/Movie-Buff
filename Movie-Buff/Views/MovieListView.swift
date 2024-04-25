//
//  MovieListView.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/22/24.
//

import SwiftUI

struct MovieListView: View {
    @EnvironmentObject var movieViewModel: MovieViewModel
    @State var isSearchTapped = false

    var body: some View {
        ZStack {
            if movieViewModel.isLoading {
                ProgressView {
                    Text("Loading")
                        .foregroundColor(.red)
                        .bold()
                }
            }
            NavigationStack {
                GeometryReader {_ in
                    ScrollView {
                        BannerImageView(movie: movieViewModel.trendingMovie.first ?? Mockdata.sampledata)
                            .overlay(content: {
                                LinearPoster()
                            })
                            .background(ScrollViewConfigurator {
                                $0?.bounces = false
                            })
                        HorizonScrollView(titleView: "Trending", movieApi: movieViewModel.trendingMovie)
                        HorizonScrollView(titleView: "Upcoming", movieApi: movieViewModel.upComingMovie)
                        HorizonScrollView(titleView: "Top Rated", movieApi: movieViewModel.topRatedMovie)
                        HorizonScrollView(titleView: "Now Playing", movieApi: movieViewModel.nowPlaying)
                        HorizonScrollView(titleView: "Top Bollywood", movieApi: movieViewModel.trendingBollywood)
                        // CategoryView()
                    }
                    .ignoresSafeArea(edges: .top)
                    .scrollIndicators(.hidden)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            SearchButtonView(isInSearch: $isSearchTapped)
                                .opacity(0.7)
                                .onTapGesture {
                                    isSearchTapped = true
                                }
                        }
                        ToolbarItem(placement: .topBarLeading) {
                            Text("Home")
                                .font(.title)
                                .foregroundStyle(.red)
                                .bold()
                        }
                    }
                   // .toolbarBackground(.hidden, for: .navigationBar)
                }
            }
        }
        .task {
            movieViewModel.getUpcomingMovie()
            movieViewModel.getTrendingMovie()
            movieViewModel.getTopRated()
            movieViewModel.getNowPlaying()
            movieViewModel.getBollywood()
        }
        .alert(item: $movieViewModel.alertItem) { alert in
            Alert(title: alert.title,
                  message: alert.message,
                  dismissButton: alert.dismissButton)
        }
    }
}

struct ScrollViewConfigurator: UIViewRepresentable {
    // swiftlint:disable:next void_return
    let configure: (UIScrollView?) -> ()
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            configure(view.enclosingScrollView())
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

extension UIView {
    func enclosingScrollView() -> UIScrollView? {
        var next: UIView? = self
        repeat {
            next = next?.superview
            if let scrollview = next as? UIScrollView {
                return scrollview
            }
        } while next != nil
        return nil
    }
}

#Preview {
    MovieListView()
        .environment(MovieViewModel())
}
