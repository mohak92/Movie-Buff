//
//  ActorDetailView.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/23/24.
//

import SwiftUI

struct ActorDetailView: View {

    @State var isRead = false
    var cast: Int
    var profilePath: String

    @EnvironmentObject var viewModel: MovieViewModel

    var body: some View {
        ZStack(alignment: .bottom) {
            if viewModel.isLoading {
                ProgressView {
                    Text("Loading")
                        .foregroundColor(.red)
                        .bold()
                }
            }
            GeometryReader {_ in
                ScrollView {
                    VStack {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)" )) { result in
                            if let image = result.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                            } else {
                                Image("noActorImage")
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                        .overlay(content: { LinearPoster() })
                        .background(ScrollViewConfigurator { $0?.bounces = false })

                        VStack(alignment: .leading, spacing: 20) {
                            Text(viewModel.actorDetail.name)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal)

                            CastBiograp(castDetail: viewModel.actorDetail)

                            VStack(alignment: .leading, spacing: 3) {
                                Text(viewModel.actorDetail.biography ?? "")
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(isRead ? 100 : 3)
                                if viewModel.actorDetail.biography?.count ?? 0 > 140 {
                                    Button(isRead ? "Read Less" : "Read More" ) {
                                        isRead.toggle()
                                    }
                                }
                            }
                            .font(.system(size: 16, weight: .regular))
                            // swiftlint:disable:next line_length
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                            .padding()
                            .multilineTextAlignment(.leading)
                        }
                        .frame(maxWidth: .infinity)

                        if !viewModel.actorImage.isEmpty {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Images")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .padding(.leading, 20)
                                    Spacer()
                                }
                                ScrollView(.horizontal) {
                                    LazyHStack {
                                        ForEach(viewModel.actorImage, id: \.filePath) { image in
                                            // swiftlint:disable:next line_length
                                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(image.filePath ?? "")"), scale: 4.5)
                                                .frame(width: 110, height: 162.91)
                                                .scaledToFit()
                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                                .scrollTransition { content, phase in
                                                    content
                                                        .scaleEffect(phase.isIdentity ? 1 : 0.45)
                                                        .blur(radius: phase.isIdentity ? 0 : 2.5)
                                                }
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
                        CastMovieCreditsView(titleView: "Movie", personId: cast)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .task {
            viewModel.getCastDetail(cast: String(cast))
            viewModel.getCastImages(cast: cast)
        }
        .ignoresSafeArea(edges: .top)
        .alert(item: $viewModel.alertItem) { alert in
            Alert(title: alert.title,
                  message: alert.message,
                  dismissButton: alert.dismissButton)
        }
    }
}

struct CastBiograp: View {

    var castDetail: ActorDetail

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Capsule()
                    .strokeBorder(Color("BorderColor"), lineWidth: 1)
                    .frame(width: 80, height: 25)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .opacity(0.6)
                    .overlay {
                        HStack {
                            Image(systemName: "star.fill")
                                .resizable()
                                .foregroundStyle(.yellow)
                                .frame(width: 12, height: 12)
                            Text("\(castDetail.popularity, specifier: "%.2f")")
                                .fontWeight(.medium)
                                .font(.system(size: 12))
                        }
                    }
                if castDetail.birthday != nil {
                    Capsule()
                        .strokeBorder(Color("BorderColor"), lineWidth: 1)
                        .frame(width: 95, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .opacity(0.6)
                        .overlay {
                            Text("\(castDetail.birthday ?? "")")
                                .fontWeight(.medium)
                                .font(.system(size: 12))
                        }
                }
                Capsule()
                    .strokeBorder(Color("BorderColor"), lineWidth: 1)
                    .frame(width: 65, height: 25)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .opacity(0.6)
                    .overlay {
                        Text("\(castDetail.knownForDepartment)")
                            .fontWeight(.medium)
                            .font(.system(size: 12))
                    }
            }
            if castDetail.placeOfBirth != nil {
                HStack {
                    Capsule()
                        .strokeBorder(Color("BorderColor"), lineWidth: 1)
                        .frame(width: 230, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .opacity(0.6)
                        .overlay {
                            Text("\(castDetail.placeOfBirth ?? "")")
                                .fontWeight(.medium)
                                .font(.system(size: 12))
                        }
                }
            }
        }.padding(.leading)
    }
}

#Preview(body: {
    ActorDetailView(cast: 976, profilePath: "")
        .environment(MovieViewModel())
})
