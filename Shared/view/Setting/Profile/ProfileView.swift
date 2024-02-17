//
//  ProfileView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 12/05/2023.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var vm = ProfileViewModel.shared
    
    var body: some View {
        NavigationView{
            VStack(spacing: 0) {
            HStack {
               
                Image("Oval3")
                    .resizable()
                    .frame(width: 52, height: 52)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2) {
                    Label("Stella Williams", image: "tickIcon")
                        .labelStyle(ReverseLabelStyle())
                    Text("Bristol, United Kingdom")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.secondaryGray)
                }
                Spacer()
                NavigationLink {
                                SettingView()
                                    .attachPartialSheetToRoot()
                } label: {
                    Image("menuIcon")
                        .frame(width: 24, height: 24)
                        .padding(8)
                        .background(Color.darkWhite)
                        .clipShape(Circle())
                }

                
            }

            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Hi there! I’m creative individual who loves to spend time outdoors and explore new places. I work as a graphic designer and enjoy spending my free time drawing and painting.")
                    .font(.system(size: 17, weight: .regular))
                    .lineLimit(4)
                
                if vm.showMore {
                    VStack(alignment: .leading) {
                        HStack(alignment: .top,spacing: 16) {
                            Text("Occupation")
                                .foregroundColor(.secondaryGray)
                            Text("Student")
                        }
                        HStack(alignment: .top,spacing: 20) {
                            Text("Interests")
                                .foregroundColor(.secondaryGray)
                            Text("🌈 LGBT+ friendly \n 🐱 Has a cat \n🙌 Interested in teaming-up")
                        }
                        HStack(alignment: .top,spacing: 16) {
                            Text("Language")
                                .foregroundColor(.secondaryGray)
                            Text("English, Japanese")
                        }
                    }
                    .font(.system(size: 17, weight: .regular))
                    Text("MEMBER SINCE DEC 4, 2020")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.secondaryGray)
                        .padding(.top, 8)
                } else {
                    Button {
                        vm.showMore = true
                    } label: {
                        Text("Show More")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.secondaryGray)
                    }
                }
            }
            .padding(.top, 12)
            .padding(.bottom, 8)
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(ProfileTab.allCases, id: \.title){ profileTab in
                        Button {
                            vm.selectedTab = profileTab
                            vm.selectedTabIndex = profileTab.rawValue
                        } label: {
                            Text(profileTab.title)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(vm.selectedTab == profileTab ? .white : .black)
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .if(vm.selectedTab == profileTab ) {
                                    $0.background(
                                        Capsule()
                                            .fill(Color.appPrimary)
                                    )
                                }
                        }
                        
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
        
            Divider()
            
            TabView(selection: $vm.selectedTabIndex) {
                alreadyBookedProfileTab
                    .tag(0)
                lookingForPartnersProfileTab
                    .tag(1)
                reviewProfileTab
                    .tag(2)
                wishlistProfileTab
                    .tag(3)
                Text("Draft")
                    .tag(4)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }

    }
    
    var alreadyBookedProfileTab: some View {
        ScrollView {
            VStack(spacing: 4) {
                ForEach(1...3, id: \.self) { i in
                    BookedPostView()
                }
            }
            .background(Color.darkWhite)
        }
    }
    
    var lookingForPartnersProfileTab: some View {
        ScrollView {
            VStack(spacing: 4) {
                ForEach(1...4, id: \.self) { i in
                    LookingForPartnerView()
                }
            }
            .background(Color.darkWhite)
        }
    }
    
    var reviewProfileTab: some View {
        ScrollView {
            VStack(spacing: 4) {
                ForEach(1...4, id: \.self) { i in
                    ReviewItemView()
                }
            }
        }
        .background(Color.darkWhite)
    }
    
    var wishlistProfileTab: some View {
        ScrollView {
            VStack(spacing: 4) {
                ForEach(1...3, id: \.self) { i in
                    BookedPostView()
                }
            }
        }
        .background(Color.darkWhite)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
