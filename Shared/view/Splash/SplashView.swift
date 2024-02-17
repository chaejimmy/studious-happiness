//
//  SplashView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 15/05/2023.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("LightBlue"), Color("7DAAFF")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)


            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isActive = true
            }
        }
        .fullScreenCover(isPresented: $isActive, content: {
            NavigationView {
                OnboardingView()
            }
        })
    }
}

