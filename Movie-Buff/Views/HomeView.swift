//
//  ContentView.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/17/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {

    let movieService: MovieService = MovieService()

    var body: some View {
        TabView {
            MovieListView()
                .tabItem { Label("Movie", systemImage: "film") }
            ActorListView()
                .tabItem { Label("Actor", systemImage: "rectangle.portrait.on.rectangle.portrait.angled.fill") }
            FavoriteMovieListView()
                .tabItem { Label("Lists", systemImage: "heart.circle") }
        }
    }

}

#Preview {
    HomeView()
        .environment(MovieViewModel())
}
