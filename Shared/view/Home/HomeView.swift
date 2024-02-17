//
//  HomeView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 08/05/2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeVM = HomeViewModel()
    @FocusState var searchFocused: Bool
    @State var searchAnimation: Bool = false
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: true) {
                LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                    if !searchAnimation {
                        searchView
                    }
                    
                    Section {
                        if searchAnimation {
                            SearchResultView(){ search in
                                homeVM.searchText = search
                                searchToggle()
                            }
                        } else {
                            VStack(spacing: 4){
                                if homeVM.selectedBookedType == BookedType.alreadyBooked {
                                    
                                       
                                        
                                        ForEach(0...3, id: \.self) { item in
                                            BookedPostView()
                                        }
                                        
                                       
                                    
                                    
                                }else {
                                    
                                    ForEach(0...3, id: \.self) { item in
                                        LookingForPartnerView()
                                    }
                                  
                                }
                               
                            }
                            .background(Color.darkWhite)
                        }
                    } header: {
                        if searchAnimation {
                            searchHeaderView
                        } else {
                            HeaderView()
                        }
                    }
                }
            
        
        }
        .clipped()
                .modal(present: $homeVM.openFilterSheet, view: FilterView() {
                    homeVM.openFilterSheet = false
                })
       
    }
    
    var searchView: some View {
        HStack(spacing: 4) {
            if searchAnimation {
                Button {
                    searchToggle()
                } label: {
                    Image("arrowBackIcon")
                        .frame(width: 22, height: 22)
                        .padding(6)
                }
            }

            HStack(spacing: 12) {
                Image("searchIcon")
                    .frame(width: 24, height: 24)
                TextField("CA, United States", text: $homeVM.searchText)
                    .focused($searchFocused)
                    .font(.system(size: 17, weight: .regular))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 18)
            .background {
                Capsule()
                    .fill(Color.lightGray)
                    .overlay {
                        Capsule()
                            .stroke(style: StrokeStyle(lineWidth: searchAnimation ? 1 : 0))
                            .foregroundColor(.appPrimary)
                    }
                    .padding(.vertical, 0.5)
            }
            .onTapGesture {
                searchToggle(isShow: true)
            }

            Button {
                homeVM.openFilterSheet = true
            } label: {
                Image("filterIcon")
                    .frame(width: 30, height: 30)
                    .padding(8)
                    .background {
                        Circle()
                            .fill(Color.lightGray)
                    }
            }
        }
        .padding(.horizontal)
        .background(Color.white)
    }
    
    var searchHeaderView: some View {
        VStack(spacing: 0) {
            searchView
            HeaderView()
        }
    }
    
    func HeaderView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                TypeSelectionView(selectedType: homeVM.selectedBookedType) { bookedType in
                    withAnimation(.easeInOut) {
                        homeVM.selectedBookedType = bookedType
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
            if searchAnimation {
                DateAndPersonSelectionView(dateAction: {}, personsAction: {})
                    .padding(.horizontal)
                    .padding(.bottom, 8)
            }
           
        }
        .background(Color.white)
    }
    
    func searchToggle(isShow: Bool = false){
        withAnimation(.easeInOut(duration: 0.5)) {
            searchAnimation = isShow
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            searchFocused = isShow
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
