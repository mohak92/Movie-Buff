//
//  ReviewsView.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/23/24.
//

import SwiftUI

struct ReviewsView: View {

    var movieReview: [MovieReview]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Review")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.leading, 20)
                Spacer()
            }
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(movieReview, id: \.author) { review in
                        VStack(alignment: .leading) {
                            HStack {
                                // swiftlint:disable:next line_length
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(review.authorDetails.avatarPath ?? "" )" ))
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                VStack(alignment: .leading) {
                                    Text(review.author)
                                        .font(.subheadline)
                                        .foregroundStyle(Color("InvertColor"))
                                    Text(review.authorDetails.username)
                                        .font(.system(size: 14))
                                        .foregroundStyle(Color("InvertColor"))
                                }
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .padding(.leading)
                            Spacer()
                                .frame(height: 20)
                            Text(review.content)
                                .multilineTextAlignment(.leading)
                                .font(.caption)
                                .lineLimit(3)
                                .padding(.horizontal)
                        }
                        .foregroundStyle(Color("InvertColor"))
                        .frame(width: 300, height: 140)
                        .background(Color("BorderColor"))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .scrollTransition { content, phase in
                            content
                                .scaleEffect(phase.isIdentity ? 1 : 0.9)
                                .blur(radius: phase.isIdentity ? 0 : 2.5)
                        }
                    }
                }.padding(.leading)
                    .scrollTargetLayout()
            }.scrollTargetBehavior(.viewAligned)
                .safeAreaPadding(.horizontal, 10)
        }
    }
}
