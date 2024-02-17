////
//  ProfileView.swift
//  bug-free-goggles
//
//  Created by Mac on 05/05/23.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    @StateObject var vm = ProfileViewModel()
    var isMyProfile: Bool = false
    var roomMate: RoommateData
    @State var shouldShowSettings: Bool = false
    @State var shouldShowAdds: Bool = false
    @State var shouldShowBookingView: Bool = false
    @State var selectedTabIndex: Int = 0
    @State var selectedTab: ProfileTabs = .alreadyBooked
    let minDragTranslationForSwipe: CGFloat = 50
    let numTabs = 5
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
//                if !isMyProfile {
//                    CustomNavBar(title: roomMate.name){
//                        dismiss()
//                    }
//                    Divider()
//                        .background(Color.darkWhite)
//                }
                HStack {
                    UserProfileView(
                        image: roomMate.images?[0].url ?? "",
                        name: roomMate.name ,
                        address: roomMate.address ,
                        size: 80
                    )
                    if isMyProfile {
                        Button {
                            shouldShowSettings.toggle()
                        } label: {
                            Image("menuIcon")
                                .frame(width: 24, height: 24)
                                .padding(8)
                                .background(Color.darkWhite)
                                .clipShape(Circle())
                        }
                    } else {
                        Button {
                            withAnimation {
                                vm.isLiked.toggle()
                            }
                        } label: {
                            Image(systemName: vm.isLiked ? "heart.fill" : "heart" )
                                .frame(width: 28, height: 28)
                                .foregroundColor(vm.isLiked ? .red : .black)
                                .padding(8)
                                .background(Color.darkWhite)
                                .clipShape(Circle())
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
               
                VStack(alignment: .leading, spacing: 4) {
                    Text(roomMate.bio)
                        .font(.circular(size: 18, weight: .light))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(4)
                   
                    if vm.showMore {
                        Divider() .padding(.top,5)
                        GridArrangeView(list: roomMate.roomMateDetails())
                        
                        Divider() .padding(.top,5)
                    } else {
                       
                        Button {
                            vm.showMore = true
                        } label: {
                            Text("Show More")
                                .font(.circular(size: 13, weight: .book))
                                .foregroundColor(.secondaryGray)
                        }
                    }
                }
                .padding(.top, 12)
                .padding(.bottom, 8)
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(isMyProfile ? ProfileTabs.allCases : ProfileTabs.otherUserProfileTabs, id: \.title){ profileTab in
                            Button {
                                selectedTab = profileTab
                                selectedTabIndex = profileTab.rawValue
                            } label: {
                                Text(profileTab.title)
                                    .font(.circular(size: 15, weight: .medium))
                                    .foregroundColor(selectedTab == profileTab ? .white : .black)
                                    .padding(.horizontal)
                                    .padding(.vertical, 10)
                                    .if(selectedTab == profileTab ) {
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
                
                TabView(selection: $selectedTabIndex) {
                    alreadyBookedProfileTab
                        .onTapGesture {
                            shouldShowBookingView.toggle()
                        }
                        .tag(0)
                        .highPriorityGesture(DragGesture().onEnded({
                            self.handleSwipe(translation: $0.translation.width)
                        }))
                    
                    lookingForPartnersProfileTab
                        .onTapGesture {
                            shouldShowBookingView.toggle()
                        }
                        .tag(1)
                        .highPriorityGesture(DragGesture().onEnded({
                            self.handleSwipe(translation: $0.translation.width)
                        }))
                    
                    reviewProfileTab
                        .onTapGesture(perform: {
                            shouldShowBookingView.toggle()
                        })
                        .tag(2)
                        .highPriorityGesture(DragGesture().onEnded({
                            self.handleSwipe(translation: $0.translation.width)
                        }))
                    
                    if isMyProfile {
                        wishlistProfileTab
                            .onTapGesture {
                                shouldShowBookingView.toggle()
                            }
                            .tag(3)
                            .highPriorityGesture(DragGesture().onEnded({
                                self.handleSwipe(translation: $0.translation.width)}) )
                        Text("Draft")
                            .tag(4)
                            .highPriorityGesture(DragGesture().onEnded({
                                self.handleSwipe(translation: $0.translation.width)
                            }))
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            
            //            if isMyProfile && !appState.shouldShowAdds {
            //                Button {
            //                    appState.shouldShowAdds = true
            //                } label: {
            //                    Image(systemName: "plus")
            //                        .frame(width: 28, height: 28)
            //                        .foregroundColor(.white)
            //                        .padding(12)
            //                        .background(Color.appPrimary)
            //                        .clipShape(Circle())
            //                }
            //                .padding(16)
            //                .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 5)
            //            }
        }
        .navigationDestination(isPresented: $shouldShowSettings) {
            SettingView()
        }
        .toolbar(.hidden, for: .navigationBar)
        //        .fullScreenCover(isPresented: $appState.shouldShowHostingView, content: {
        //           NavigationStack{
        //               HostAddressSelectionView()
        //            }
        //          })
        //        .fullScreenCover(isPresented: $appState.shouldShowPartnerHostingView, content: {
        //           NavigationStack{
        //               HostAddressSelectionView()
        //            }
        //          })
        .navigationDestination(isPresented: $shouldShowBookingView, destination: {
            BookedDetailsView(data: PreviewData.bookingData)
        })
        //        .sheet(isPresented: $appState.shouldShowAdds){
        //            HostingSelection()
        //                .environmentObject(appState)
        //                .presentationDetents([.medium])
        //        }
        ///OnboardingView
    }
    
    //for handling horizontal swipe on user profile tab
    private func handleSwipe(translation: CGFloat) {
        if translation > minDragTranslationForSwipe && selectedTabIndex > 0 {
            withAnimation{
                selectedTabIndex -= 1
                handleTabSelection(selectedTabIndex)
            }
        } else  if translation < -minDragTranslationForSwipe && selectedTabIndex < numTabs-1 {
            withAnimation{
                selectedTabIndex += 1
                handleTabSelection(selectedTabIndex)
            }
        }
    }
    
    private func handleTabSelection(_ tabIndex: Int){
        switch tabIndex {
        case 0: selectedTab = .alreadyBooked
        case 1: selectedTab = .lookingfForPartners
        case 2: selectedTab = .reviews
        case 3: selectedTab = .wishlist
        case 4: selectedTab = .draft
        default:
            selectedTab = .alreadyBooked
        }
    }
    var alreadyBookedProfileTab: some View {
        ScrollView {
            VStack(spacing: 4) {
                ForEach(1...3, id: \.self) { i in
                    UnavailablePostView(roomMate: PreviewData.roomMateData,
                                        editClicked: {    appState.shouldShowPartnerHostingView.toggle()
                    },
                                        deleteClicked: {},isMyProfile: isMyProfile)
                }
            }
            .background(Color.darkWhite)
            .padding(.bottom, 68)
        }
    }
    
    var lookingForPartnersProfileTab: some View {
        ScrollView {
            VStack(spacing: 4) {
                ForEach(1...4, id: \.self) { i in
                    UnavailablePostView(roomMate: PreviewData.roomMateData,
                                        editClicked: {                      appState.shouldShowPartnerHostingView.toggle()
                    },
                                        deleteClicked: {},isMyProfile: isMyProfile)
                }
            }
            .background(Color.darkWhite)
            .padding(.bottom, 68)
        }
    }
    
    var reviewProfileTab: some View {
        ScrollView {
            VStack(spacing: 4) {
                ForEach(1...4, id: \.self) { i in
                    ReviewItemView()
                }
            }
            .background(Color.darkWhite)
            .padding(.bottom, 68)
        }
    }
    
    var wishlistProfileTab: some View {
        ScrollView {
            VStack(spacing: 4) {
                ForEach(1...3, id: \.self) { i in
                    BookedPostView(data: PreviewData.bookingData,
                                   deleteClicked: {},
                                   editClicked: { appState.shouldShowPartnerHostingView.toggle()},
                                   isMyProfile:isMyProfile
                    )
                }
            }
            .background(Color.darkWhite)
            .padding(.bottom, 68)
        }
    }
    
    
}


struct SelectTotelAction: View {
    var title: String
    var caption: String
    var image: String
    var clicked: (() -> Void)
    var body: some View {
        HStack {
            VStack (alignment: .leading,spacing: 5){
                Text(title)
                    .font(.circular(size: 18,weight:.medium))
                    .font(.headline)
                
                Text(caption)
                    .font(.circular(size: 14))
            }
            Spacer()
            Image(image)
                .resizable()
                .frame(width: 100,height: 80)
        }
        .padding()
        .frame(width: getScreenBounds().width * 0.95, height: 100)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 5)
        .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: -5)
        .onTapGesture {
            withAnimation(.spring()) { clicked() }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
//            HostingSelection()
//                .environmentObject(AppState())
             ProfileView(isMyProfile: true, roomMate: PreviewData.roomMateData)
            
        }
    }
}
