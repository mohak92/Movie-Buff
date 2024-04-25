//
//  Movie_BuffApp.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/17/24.
//

import SwiftUI
import SwiftData

@main
struct MovieBuffApp: App {

    @StateObject var movieViewModel = MovieViewModel()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(movieViewModel)
        }
    }
}
