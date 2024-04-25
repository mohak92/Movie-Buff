//
//  MovieDetailView.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/22/24.
//

import SwiftUI

struct MovieDetailView: View {

    var movie: Movie

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    MovieDetailView(movie: Mockdata.sampledata)
        .environment(MovieViewModel())
}
