////
//  HomeView.swift
//  bug-free-goggles
//
//  Created by Mac on 03/05/23.
//

import SwiftUI
import LoaderUI

struct HomeView: View {
    @ObservedObject var homeVM = HomeViewModel.shared
    @FocusState var searchFocused: Bool
    @State var searchAnimation: Bool = false
    @State var isHourlyShowing: Bool = false
    @State var isFindRoommateShowing: Bool = false
    @State private var showFullCalendar: Bool = false
    @StateObject private var calendarManager = CalendarManager.shared
    @EnvironmentObject var routerPath: RouterPath
    
    @State private var shouldShowRoommateView: Bool = false
    
    var body: some View {
        LoadingView(isShowing: $homeVM.isLoading) {
            content
        }
    }
    
    var content: some View {
        //LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
        VStack {
            if !searchAnimation {
                searchView.padding(.top)
            }
            Section {
                if searchAnimation {
                    SearchResultView(){ search in
                        homeVM.searchText = search
                        searchToggle()
                    }
                } else {
                    categoriesView
//                    if homeVM.allHosts.isEmpty {
//                        Spacer()
//                        BallClipRotate()
//                            .foregroundColor(Color.darkIndigo).frame(width: 70, height: 70)
//                        Spacer()
//                        Spacer()
//                    }else{
//
//
//                    }
                    
                    ScrollView(showsIndicators:false){
                        switch homeVM.selectedBookedType {
                        case .hourlyRoom: HourlyRoomView(rooms: homeVM.allHosts) { room in
                            isHourlyShowing = true
                        }
                        case .travelRoommate: //GridRoomView()
                            RoommateListView(navigation: $shouldShowRoommateView){
                                isFindRoommateShowing = true
                            }
                        case .electricCharging: lookingForPartnerView
                        default: alreadyBookedView
                        }
                    }
                }
                
                
            } header: {
                if searchAnimation {
                    searchHeaderView.padding(.top)
                } else {
                    // HeaderView()
                }
            }
        }
        .navigationDestination(isPresented: $isHourlyShowing) {
            HourlyBookingView()
        }
        .navigationDestination(isPresented: $isFindRoommateShowing) {
            BookedDetailsView(data: PreviewData.bookingData)
        }
        .clipped()
        .sheet(isPresented: $homeVM.openFilterSheet) {
            //FilterView(dismiss: {homeVM.openFilterSheet = false})
            SearchView(dismiss: {homeVM.openFilterSheet = false})
        }
        .sheet(isPresented: $showFullCalendar) {
            MonthCalendarView()
                .presentationDetents([.height(370)])
                .environmentObject(calendarManager)
        }
        
        
        //        .modal(present: $homeVM.openFilterSheet, view:FilterView()  {
        //            homeVM.openFilterSheet = false
        //        })
        //.toolbar(.hidden, for: .navigationBar)
    }
    private var headerView: some View {
        VStack(alignment: .leading) {
            selectedWeekText
                .padding(.bottom)
            WeekCalendarView()
                .frame(height: 70)
                .environmentObject(calendarManager)
        }
    }
    
    private var selectedWeekText: some View {
        Button {
            showFullCalendar = true
        } label: {
            HStack(spacing: 8) {
                Text(selectedWeekString)
                    .font(.circular(size: 20, weight: .medium))
                
                Image("arrow_down")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16, alignment: .center)
            }
            .foregroundColor(Color(red: 0.153, green: 0.176, blue: 0.216))
        }
        .padding(.horizontal, 16)
    }
        
        
    private var selectedWeekString: String {
        let startDate = calendarManager.selectedDate.startOfWeek
        let endDate = calendarManager.selectedDate.endOfWeek
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        let start = formatter.string(from: startDate)
        let end = formatter.string(from: endDate)
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        let year = yearFormatter.string(from: startDate)
        
        return "\(start) - \(end), \(year)" // startDate + " - " + endDate + ", " + year
    }
        
    var categoriesView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(BookedType.allCases, id: \.self) { type in
                    Button {
                        homeVM.selectedBookedType = type
                    } label: {
                        VStack(spacing: 8) {
                            Image(type.image)
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 30, height: 30)
                                .foregroundColor(homeVM.selectedBookedType == type ? .appPrimary : .black)
                            
                            Text(type.title)
                                .font(.caption)
                                .foregroundColor(homeVM.selectedBookedType == type ? .appPrimary : .black)
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                        }
                        
                    }
                }
            }
            .padding(16)
        }
    }
    @ViewBuilder
    var alreadyBookedView: some View {
        VStack(spacing: 4){
            ForEach(homeVM.allBookings, id: \.id) { data in
                // NavigationLink(destination: BookedDetailsView(data: data)) {
                Button {
                    //  routerPath.navigate(to: .partnerDetail(roommateData: data))
                } label: {
                    BookedPostView(data: data,deleteClicked: {},editClicked: {},isMyProfile: true)
                }
            }
        }
        .background(Color.darkWhite)
        
    }
    
    var lookingForPartnerView: some View {
        VStack(spacing: 4){
            ForEach(homeVM.allRoomMates, id: \.id) { data in
                // NavigationLink(destination: PartnerDetailsView(roomMate: data)) {
                UnavailablePostView(roomMate: data,editClicked: {},deleteClicked: {},isMyProfile: true)
                    .onTapGesture {
                        routerPath.navigate(to: .partnerDetail(roommateData: data))
                    }
                // }
            }
        }
        .background(Color.darkWhite)
    }
    
    var rentedRoomView: some View {
        VStack(spacing: 4){
            Text("Rent Room")
        }
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
            
            HStack() {
                Image("searchIcon")
                    .resizable()
                    .frame(width: 24, height: 24).padding(.leading, 10)
                if !searchAnimation {
                    VStack(alignment: .leading) {
                        Text("Where to?")
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                            .lineLimit(1)
                        Text("Anywhere • Any week • Add guests")
                            .font(Font.system(size: 14))
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                    }
                }else {
                    TextField("Search destination", text: $homeVM.searchText)
                        .focused($searchFocused)
                        .font(.system(size: 17, weight: .regular))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Spacer()
                Button {
                    homeVM.openFilterSheet = true
                } label: {
                    Image("filterIcon")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(10)
                        .background {
                            Circle()
                                .stroke(Color.midGray, lineWidth: 1)
                        }
                }
                                
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
            .background {
                
                Capsule()
                    .stroke(Color.midGray, lineWidth: 1)
                    .shadow(color: Color.black, radius: 10, x: 0, y: 10)
                    .overlay {
                        Capsule()
                            .stroke(style: StrokeStyle(lineWidth: searchAnimation ? 1 : 0))
                            .foregroundColor(.appPrimary)
                    }
                
                Capsule().fill(Color.white)
            }
            .onTapGesture {
                searchToggle(isShow: true)
            }
            
            
        }
        .padding(.horizontal)
        .background(Color.white)
        
        
    }
    
    var searchHeaderView: some View {
        VStack(spacing: 0) {
            searchView
            //HeaderView()
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
            Divider()
                .background(Color.lightGray)
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


struct DummyView: View {
    var body: some View {
        NavigationLink {
            Text("Not Hang in this Flow")
        } label: {
            Text("2nd Time Navigate")
        }
    }
}
