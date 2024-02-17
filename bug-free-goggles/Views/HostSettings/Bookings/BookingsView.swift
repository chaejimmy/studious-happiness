//
//  BookingsView.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 31/08/2023.
//

import SwiftUI
import FSCalendar

struct BookingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selection = 0
    @StateObject var bookingVM = BookingsViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Group {
                VStack(alignment: .leading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 10, height: 10)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color("DarkWhite"))
                            .clipShape(Circle())
                    }
                    
                    Text("Bookings")
                        .font(.system(size: 28, weight: .bold))
                }
                .padding([.horizontal, .bottom])
                .padding(.bottom)
                
                SelectionView()
            }
            .background(.white)
            
            Section {
                switch(BookingTab(rawValue: selection)){
                case .booked: AllBookingsView(bookingVM: bookingVM)
                case .history: HistoryView(bookingVM: bookingVM)
                default: BookingCalendarView(bookingVM: bookingVM)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    func SelectionView() -> some View {
        var labels: [String]{
            return BookingTab.allCases.map{$0.title}
        }
        return CustomSegmentedControl(selection: $selection, segmentLabels: labels)
    }
}



struct BookingsView_Previews: PreviewProvider {
    static var previews: some View {
        BookingsView()
    }
}
