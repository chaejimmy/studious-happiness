//
//  OnBoardView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 08/05/2023.
//

import SwiftUI

struct OnboardingView: View {
    @State var currentIndex: Int = 0
    @State var showSignIn: Bool = false
    @State var showSignUp: Bool = false
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color.black)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color.black.opacity(0.2))

    }
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: 12) {
                TabView(selection: $currentIndex) {
                    OnboardItemView(
                        image: "onboard1",
                        title: "Shared living space",
                        desc: "What fun could we have more than having roommate with similar interest."
                    )
                    .tag(0)
                    OnboardItemView(
                        image: "onboard2",
                        title: "Find places around you",
                        desc: "You can find places and stay with hotels and home-stays ranked by travellers."
                    )
                    .tag(1)
                    OnboardItemView(
                        image: "onboard3",
                        title: "Find places around you",
                        desc: "You can find places and stay with hotels and home-stays ranked by travellers."
                    )
                    .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                HStack (spacing: 10){
                    ForEach(0...2,id: \.self){ index in
                        Circle ()
                            .fill(Color.black.opacity(currentIndex == index ? 1: 0.1))
                            .frame (width: 6, height: 6)
                            .scaleEffect (currentIndex == index ? 1.4 : 1)
                            .animation(.spring(), value: currentIndex == index)
                    }
                }
                .padding(.vertical, 20)
                VStack(spacing: 12) {
                    NavigationLink {
                        LoginInView(isForLogin: false)
                    } label: {
                        Text("Create an account")
                    }
                    .buttonStyle(BorderedButtonStyle())
                    
                    NavigationLink {
                        LoginInView(isForLogin: true)
                    } label: {
                        Text("Sign In")
                    }
                    .buttonStyle(PrimaryButtonStyle(background: .black))
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .ignoresSafeArea()
            .background(Color.white)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}

struct OnboardItemView: View {
    let image: String
    let title: String
    let desc: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            Text(title)
                .font(.system(size: 28, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.top, 20)
                .padding(.horizontal)
            Text(desc)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.secondaryGray)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal)
        }
        .ignoresSafeArea()
        
    }
}

struct OnboardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
