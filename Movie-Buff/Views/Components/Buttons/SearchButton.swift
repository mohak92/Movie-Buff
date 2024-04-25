//
//  SearchButton.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/23/24.
//

import SwiftUI

struct SearchButtonView: View {

    @Binding var isInSearch: Bool

    var body: some View {
        HStack {
            NavigationLink(destination: SearchResultsView(isInSearch: $isInSearch)) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.red)
                        .bold()
                }
            }
        }
    }
}
