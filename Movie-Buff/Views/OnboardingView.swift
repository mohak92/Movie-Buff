//
//  OnboardingView.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/24/24.
//

import SwiftUI

struct OnboardingView: View {

    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true

    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 40
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var arrowIconOpacity: Double = 1.0
    @State private var textTitle: String = "Movie Buff"

    let hapticFeedback = UINotificationFeedbackGenerator()

    var body: some View {
        ZStack {
            Color("ColorBlue").ignoresSafeArea(.all, edges: .all)
            VStack(spacing: 10) {

                Spacer()

                VStack(spacing: 0) {
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)

                    Text("""
                        Millions of movies, TV shows and people to discover. Explore now.
                        """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeIn(duration: 0.5), value: isAnimating)

                ZStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width, y: imageOffset.height)
                        .rotationEffect(.degrees(Double(imageOffset.width / 30)))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                    }
                                    withAnimation(.linear(duration: 0.25), {
                                        arrowIconOpacity = 0
                                        textTitle = "Lets Dive In"
                                    })
                                }
                                .onEnded { _ in
                                    imageOffset = .zero

                                    withAnimation(.linear(duration: 0.25), {
                                        arrowIconOpacity = 1
                                        textTitle = "Movie Buff"
                                    })
                                }
                        )
                        .animation(.easeInOut(duration: 0.5), value: imageOffset)
                }
                .overlay(alignment: .bottom, content: {
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 40))
                        .fontWeight(.ultraLight)
                        .foregroundColor(.white)
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y: 30)
                        .opacity(arrowIconOpacity)
                        .animation(.easeOut(duration: 1).delay(3), value: isAnimating)
                })
                Spacer()

                ZStack {
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .offset(x: 20)
                    Capsule()
                        .fill(.white.opacity(0.2))
                    Capsule()
                        .fill(.white.opacity(0.2))
                        .padding(8)
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                        .frame(width: buttonOffset + 80)
                        Spacer()
                    }
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))

                            Circle()
                                .fill(.black.opacity(0.2))
                                .padding(8)

                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .heavy))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded {_ in
                                    withAnimation(.easeOut(duration: 0.5)) {
                                        if buttonOffset < (buttonWidth - 80) / 2 {
                                            hapticFeedback.notificationOccurred(.warning)
                                            buttonOffset = 0
                                        } else {
                                            buttonOffset = buttonWidth - 80
                                            hapticFeedback.notificationOccurred(.success)
                                            playAudio(filename: "netflix", fileType: "mp3")
                                            isOnboardingViewActive = false

                                        }
                                    }

                                }
                        )
                        Spacer()
                    }

                }
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding(10)
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeIn(duration: 0.5), value: isAnimating)

            }
        }
        .onAppear(perform: {
            isAnimating = true
        })
        .preferredColorScheme(.dark)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
