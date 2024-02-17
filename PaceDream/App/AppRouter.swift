////
//  AppRouter.swift
//  bug-free-goggles
//
//  Created by Mac on 27/07/2023.
//

import SwiftUI


@MainActor
extension View {
  func withAppRouter() -> some View {
    navigationDestination(for: RouterDestination.self) { destination in
      switch destination {
    
      case let .partnerDetail(roommateData):
          PartnerDetailsView(roomMate: roommateData)
      case let .bookedDetail(bookingData):
          BookedDetailsView(data: bookingData)
      case .newTimeSchedule:
          NewTimeReschedulingView()
              .withEnvironments()
      case .basicSetUp:
          BasicSetUpView()
              .withEnvironments()
        

      }
    }
  }

  func withSheetDestinations(sheetDestinations: Binding<SheetDestination?>) -> some View {
    sheet(item: sheetDestinations) { destination in
      switch destination {
      case .monthCalendarView:
          MonthCalendarView()
      }
    }
  }
    
func withEnvironments() -> some View {
    environmentObject(CalendarManager.shared)
}

 
}
