//
//  MovieInfoView.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/23/24.
//

import SwiftUI

struct MovieInfoView: View {

    var movieDetail: MovieDetail

    var body: some View {
        VStack {
            HStack {
                Capsule()
                    .strokeBorder(Color("BorderColor"), lineWidth: 1)
                    .frame(width: 60, height: 25)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .opacity(0.6)
                    .overlay {
                        HStack {
                            Image(systemName: "star.fill")
                                .resizable()
                                .foregroundStyle(.yellow)
                                .frame(width: 12, height: 12)
                            Text("\(movieDetail.voteAverage, specifier: "%.2f")")
                                .fontWeight(.medium)
                                .font(.system(size: 12))
                        }
                    }
                Capsule()
                    .strokeBorder(Color("BorderColor"), lineWidth: 1)
                    .frame(width: 35, height: 25)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .opacity(0.6)
                    .overlay {
                        Text("\(movieDetail.originalLanguage.uppercased())")
                            .fontWeight(.medium)
                            .font(.system(size: 12))
                    }
                Capsule()
                    .strokeBorder(Color("BorderColor"), lineWidth: 1)
                    .frame(width: 50, height: 25)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .opacity(0.6)
                    .overlay {
                        Text("\(movieDetail.runtime) M")
                            .fontWeight(.medium)
                            .font(.system(size: 12))
                    }
                Capsule()
                    .strokeBorder(Color("BorderColor"), lineWidth: 1)
                    .frame(width: 95, height: 25)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .opacity(0.6)
                    .overlay {
                        Text("\(movieDetail.releaseDate)")
                            .fontWeight(.medium)
                            .font(.system(size: 12))
                    }
            }
        }.padding(.leading)
    }
}

#Preview {
    MovieInfoView(movieDetail: Mockdata.movieDetailsample)
}
