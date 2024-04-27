//
//  HorizontalScrollCastView.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/23/24.
//

import SwiftUI

struct HorizontalScrollCastView: View {

    var titleView: String
    var cast: [Cast]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(titleView)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.leading, 20)
                Spacer()
                NavigationLink(destination: AllCastView(cast: cast, titleView: titleView)) {
                    Label("See All", systemImage: "arrow.right")
                        .labelStyle(TrailingIconLabelStyle())
                        .font(.callout)
                        .padding(.trailing, 20)
                        .padding(.top, 10)
                }
            }
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(cast) {cast in
                        // swiftlint:disable:next line_length
                        NavigationLink(destination: ActorDetailView(cast: cast.id, profilePath: cast.profilePath ?? "")) {
                            // swiftlint:disable:next line_length
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(cast.profilePath ?? "")" ), scale: 4.5)
                                .frame(width: 110, height: 162.91)
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay {
                                    OverlayCast(cast: cast)
                                }
                                .scrollTransition { content, phase in
                                    content
                                        .scaleEffect(phase.isIdentity ? 1 : 0.45)
                                        .blur(radius: phase.isIdentity ? 0 : 2.5)
                                }
                        }
                        .buttonStyle(FlatLinkStyle())
                    }
                    .padding(.leading, 15)
                }
                .frame(height: 180)
                .scrollTargetLayout()
            }
            .padding(.top, -10)
            .scrollTargetBehavior(.viewAligned)
            .safeAreaPadding(.horizontal, 10)
        }
    }
}

#Preview {
    HorizontalScrollCastView(titleView: "Cast", cast: [Cast(id: 976,
                                                  name: "Jason Statham",
                                                  originalName: "Jason Statham",
                                                  character: "Adam Clay",
                                                  profilePath: "/lldeQ91GwIVff43JBrpdbAAeYWj.jpg")])
}

struct OverlayCast: View {

    var cast: Cast

    var body: some View {
        VStack {
            Spacer()
            LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
                .frame(maxWidth: .infinity, maxHeight: 62.91)
                .overlay {
                    VStack {
                        Text(cast.name)
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .frame(width: 110, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.white)
                    }
                    .padding(.leading, 5)
                    .padding(.bottom, 10)
                }
        }
    }
}
