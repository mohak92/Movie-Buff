//
//  Banner.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/22/24.
//

import SwiftUI

struct BannerImageView: View {

    var movie: Movie

    var body: some View {
        VStack(alignment: .leading) {
            if let url = movie.posterURL {
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    AsyncImage(url: url) { result in
                        result.image?
                            .resizable()
                            .scaledToFill()
                    }
                }.buttonStyle(FlatLinkStyle())
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}
