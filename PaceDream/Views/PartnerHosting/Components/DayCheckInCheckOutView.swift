////
//  DayCheckInCheckOutView.swift
//  bug-free-goggles
//
//  Created by Mac on 02/06/23.
//

import SwiftUI

struct DayCheckInCheckOutView: View {
    @EnvironmentObject var vm: PartnerHostingViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            DatePickerFieldView(title: "Check-In", date: vm.checkInDate) { date in
                vm.checkInDate = date
            }
            
            DatePickerFieldView(title: "Check-Out", date: vm.checkOutDate, rangeAfterDate: vm.checkInDate.addingTimeInterval(24*3600)) { date in
                vm.checkOutDate = date
            }
        }
    }
}

struct DayCheckInCheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        DayCheckInCheckOutView()
            .environmentObject(PartnerHostingViewModel())
    }
}
