//
//  ContextMenuMovieCell.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/22/24.
//

import SwiftUI

struct ContextMenuMovieCell: View {

    var movie: Movie

    var body: some View {
        NavigationLink(destination: MovieDetailView(movie: movie)) {
            Label("Overview", systemImage: "doc.plaintext.fill")
        }

    }
}
