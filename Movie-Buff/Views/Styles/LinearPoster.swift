//
//  LinearPoster.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/22/24.
//

import SwiftUI

struct LinearPoster: View {
    var body: some View {
        VStack {
            LinearGradient(colors: [.clear, .black], startPoint: .bottom, endPoint: .top)
                .frame(maxWidth: .infinity, maxHeight: 140)
            Spacer()
            LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
                .frame(maxWidth: .infinity, maxHeight: 190)
        }
    }
}

#Preview {
    LinearPoster()
}
