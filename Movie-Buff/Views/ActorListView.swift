//
//  ActorListView.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/22/24.
//

import SwiftUI

struct ActorListView: View {

    @EnvironmentObject var movieViewModel: MovieViewModel

    var body: some View {
        NavigationStack {
            if movieViewModel.isLoading {
                ProgressView {
                    Text("Loading")
                        .foregroundColor(.red)
                        .bold()
                }
            }
            ZStack {
                List {
                    ForEach(movieViewModel.trendingActor) { cast in
                        // swiftlint:disable:next line_length
                        NavigationLink(destination: ActorDetailView(cast: cast.id, profilePath: cast.profilePath ?? "")) {
                            HStack {
                                // swiftlint:disable:next line_length
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(cast.profilePath ?? "")"), scale: 4.5 )
                                    .frame(width: 100, height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                VStack(alignment: .leading) {
                                    Text(cast.name)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    Text("Department: \(cast.knownForDepartment ?? "")")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                    Text("Rating: \(cast.popularity, specifier: "%.2f")")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                }.padding(.leading)
                            }
                        }
                    }
                }.listStyle(.plain)
                    .padding(.top)
            }
            .onAppear {
                movieViewModel.getTrendingActor()
            }
            .alert(item: $movieViewModel.alertItem) { alert in
                Alert(title: alert.title,
                      message: alert.message,
                      dismissButton: alert.dismissButton)
            }
            .navigationTitle("Popular Person")
        }
    }
}

#Preview {
    ActorListView()
        .environment(MovieViewModel())
}
