//
//  MainView.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/24/24.
//

import SwiftUI

struct MainView: View {

    @StateObject var movieViewModel = MovieViewModel()
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true

    var body: some View {
        ZStack {
            if isOnboardingViewActive {
                OnboardingView()
            } else {
                HomeView()
                    .environmentObject(movieViewModel)
                    .modelContainer(for: [MovieItem.self])
            }
        }
    }
}

#Preview {
    MainView()
}
