////
//  BookingView.swift
//  bug-free-goggles
//
//  Created by Mac on 10/05/23.
//

import SwiftUI
enum Reserved: String, CaseIterable, Identifiable {
    case Booked, Wishlists, Waiting, Cancel
    var id: Self { self }
}
struct BookingView: View {
    @State private var bookings:[BookingCellModel] = [
        BookingCellModel(),
        BookingCellModel(),
        BookingCellModel(),
        BookingCellModel(),
        BookingCellModel()
    ]
    
    @State private var showSheet: Bool = false
    @ObservedObject var homeVM = HomeViewModel.shared
    @EnvironmentObject var routerPath: RouterPath
    @StateObject private var calendarManager = CalendarManager.shared
    @State private var showFullCalendar: Bool = false
    @State private var showRescheduleView: Bool = false
    @State private var shouldShowBookingView: Bool = false
    
    
    enum Tabss: String, CaseIterable {
        case booked = "Booked"
        case wishlist = "Wishlists"
        case Waiting = "Waiting"
        case Cancel = "Canceled"
    }
    @State private var selectedReservedTab: Reserved = .Booked
   
    @ViewBuilder
    var noBookingsView: some View {
        VStack(spacing: 5) {
            Image("bookingsIconHome")
                .resizable()
                .frame(width: 70, height: 70)
            Text("No bookings yet")
                .font(.title2)
                .bold()
            
        }
        .frame(alignment: .center)
    }
     
    var body: some View {
        //NavigationView {
        //NavigationStack{
        VStack(alignment: .center) {
            
            VStack(alignment:.leading){
                ReservedTabView(selectedTab: $selectedReservedTab)
                Divider()
            }
            
            Spacer()
            
            if selectedReservedTab == .Booked {
                if bookings.isEmpty {
                    noBookingsView
                } else{
                    ScrollView {
                        //                        LazyVGrid(columns: [GridItem(.flexible())], alignment: .center, pinnedViews: [.sectionHeaders]) {
                        //
                        Section {
                            if bookings.isEmpty {
                                noBookingsView
                                    .alignmentGuide(.customCenter) { context in
                                      context[HorizontalAlignment.center]
                                    }
                            }else {
                                ForEach(bookings) { booking in
                                    BookingPostCell(model: booking) {
                                        showSheet = true
                                    }
                                    .onTapGesture {
                                        routerPath.navigate(to: .bookedDetail(bookingData: PreviewData.bookingData))
                                       // shouldShowBookingView.toggle()
                                    }
                                }
                            }
                        } header: {
//                            headerView
//                                .padding(.top, 10)
//                                .background(
//                                    Color.background
//                                        .shadow(color: .primary.opacity(0.1), radius: 5, x: 0, y: 10)
//                                )
                        }
                        //    }
                        //.background(Color.lightGray)
                    }}
            } else if selectedReservedTab == .Wishlists {
                WishListView(navigation:$shouldShowBookingView)
                    
            }
            else if selectedReservedTab == .Waiting {
                noWaitingRequestsView
            }
            else if selectedReservedTab == .Cancel {
                noCanceledReservationView
            }
            Spacer()
            
        }
        
        // .navigationTitle("Bookings")
        // .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.background, for: .navigationBar)
//        .navigationDestination(isPresented: $showRescheduleView, destination: {
//            NewTimeReschedulingView()
//                .environmentObject(calendarManager)
//        })
//        .navigationDestination(isPresented: $shouldShowBookingView, destination: {
//            //                BookedDetailsView(data: homeVM.allBookings.first ??  PreviewData.bookingData)
//            BookedDetailsView(data: PreviewData.bookingData)
//        })
        .sheet(isPresented: $showSheet) {
            BottomSheetView {
                routerPath.navigate(to: .newTimeSchedule)
               // showRescheduleView = true
            }
            .presentationDetents([.height(280)])
        }
        .sheet(isPresented: $showFullCalendar) {
            MonthCalendarView()
                .presentationDetents([.height(370)])
                .environmentObject(calendarManager)
        }
        //.navigationTitle("Reserved")
        // }
        
        //}
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
    @ViewBuilder
    var noCanceledReservationView: some View {
        VStack(spacing: 5) {
            Image("wishlistIcon")
                .resizable()
                .frame(width: 70, height: 70)
            Text("No canceled reservations")
                .font(.title2)
                .bold()
            
        }
    }
    @ViewBuilder
    var noWaitingRequestsView: some View {
        VStack(spacing: 5) {
            Image("wishlistIcon")
                .resizable()
                .frame(width: 70, height: 70)
            Text("No waiting requests")
                .font(.title2)
                .bold()
            
        }
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
    
    private func headerView(title: String) -> some View {
        HStack {
            Text(title)
                .font(.circular(size: 28, weight: .bold))
            
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}
struct ReservedTabView: View {
    @Binding var selectedTab: Reserved
    
    enum Tab: String, CaseIterable {
        case booked = "Booked"
        case wishlist = "Wishlists"
        case waiting = "Waiting"
        case cancel = "Canceled"
    }
    
    var body: some View {
        HStack {
            ForEach(Reserved.allCases, id: \.self) { tab in
                Button(action: {
                    selectedTab = tab
                }, label: {
                    Text(tab.rawValue)
                        .font(.circular(size: 15, weight: .book))
                        .padding(10)
                        .foregroundColor(selectedTab == tab ? Color(red: 0.263, green: 0.494, blue: 0.969)  : Color.black)
                        .background(
                            Capsule()
                                .fill(selectedTab == tab ? Color(red: 0.961, green: 0.98, blue: 1) : Color.clear)
                        )
                        .overlay {
                            Capsule( )
                                .stroke(selectedTab == tab ? Color.blue :Color.clear, lineWidth: 0.5)
                                }
                    
                })
                //Spacer()
            }
            //.padding(.horizontal, 20)
            .frame(minWidth:50,alignment: .leading)
            Spacer()
        }
        .padding(.leading)
    }
}

struct BookingCellModel: Identifiable {
    var id: String = UUID().uuidString
    var name: String = "Alex Norman"
    var address: String = "CA, United States."
    var profilePic: String = "moc_profilePic"
    var image: String = "cleanhomepic"
    var hotelName: String = "Brunel's SS Great Britain"
    var hotelAddress: String = "Great Western Dockyard, Gas Ferry Rd, Bristol BS1 6TY"
    var bookedDateString: String = "25 Jan, 2023"
    var priceString: String = "$25/Hour"
    var reservedTimeString: String = "Reserved 4 Hours"
}

struct BookingPostCell: View {
    var model: BookingCellModel
    var onReschedule: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            topView
            
            Image(model.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 233)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            hotelDetailView
            
            bottomView
        }
        .padding()
        .background(Color.background)
    }
    
    private var topView: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(model.profilePic)
                .resizable()
                .frame(width: 48, height: 48)
                .aspectRatio(1, contentMode: .fit)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(model.name)
                        .font(.circular(size: 16, weight: .medium))
                    
                    Image("tickIcon")
                }
                
                Text(model.address)
                    .font(.circular(size: 15, weight: .book))
            }
            
            Spacer(minLength: 0)
            
            
            Button {
                // on tap more button
            } label: {
                Image("moreIcon")
            }
        }
    }
    
    private var hotelDetailView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(model.hotelName)
                .font(.circular(size: 16, weight: .medium))
            
            Text(model.hotelAddress)
                .font(.circular(size: 13, weight: .book))
                .foregroundColor(.secondary)
                .padding(.bottom, 4)
            
            Text(model.bookedDateString)
                .font(.circular(size: 13, weight: .book))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var bottomView: some View {
        HStack {
            Text(model.priceString)
                .font(.circular(size: 14, weight: .book))
            
            Spacer(minLength: 0)
            
            Text(model.reservedTimeString)
                .font(.circular(size: 14, weight: .bold))
                .foregroundColor(Color(red: 0.263, green: 0.494, blue: 0.969))
                .padding(.horizontal, 8)
                .padding(.vertical, 3)
                .background {
                    Capsule()
                        .fill(Color(red: 0.961, green: 0.98, blue: 1))
                }
            
            Button {
                // On tap edit
                onReschedule()
            } label: {
                Image("pencil_Circle_Icon")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
        }
    }
}

struct BookingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            BookingView()
        }
    }
}
extension HorizontalAlignment {
  static let customCenter: HorizontalAlignment = .init(CustomCenter.self)
}

struct CustomCenter: AlignmentID {
  static func defaultValue(in context: ViewDimensions) -> CGFloat {
    context[HorizontalAlignment.center]
  }
}
