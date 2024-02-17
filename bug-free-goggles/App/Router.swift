////
//  Router.swift
//  bug-free-goggles
//
//  Created by Mac on 27/07/2023.
//

 
import Combine
import Foundation
import Network
import SwiftUI

//for RouterDestination you can refer this github repo https://github.com/Dimillian/IceCubesApp
// we have done it based on their pattern
// more res https://twitter.com/Dimillian/status/1682037532895354880

public enum RouterDestination: Hashable {
    case partnerDetail(roommateData: RoommateData)
    case bookedDetail(bookingData: BookingData)
    case basicSetUp
    case newTimeSchedule
         

}

public enum SheetDestination: Identifiable {
    case monthCalendarView

  public var id: String {
    switch self {
    case .monthCalendarView:
        return "monthCalendarView"
    }
  }
}

@MainActor
public class RouterPath: ObservableObject {
//  public var client: Client?
//  public var urlHandler: ((URL) -> OpenURLAction.Result)?

  @Published public var path: [RouterDestination] = []
  @Published public var presentedSheet: SheetDestination?

  public init() {}

  public func navigate(to: RouterDestination) {
    path.append(to)
  }

}
