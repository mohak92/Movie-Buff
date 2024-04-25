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

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    AllMovieView(movie: Mockdata.movielist, titleView: "Trending")
}
