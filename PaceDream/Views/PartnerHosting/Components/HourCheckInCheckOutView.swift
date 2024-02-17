////
//  HourCheckInCheckOutView.swift
//  bug-free-goggles
//
//  Created by Mac on 02/06/23.
//

import SwiftUI

struct HourCheckInCheckOutView: View {
    @EnvironmentObject var vm: PartnerHostingViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            DatePickerFieldView(title: "Date", date: vm.date) { date in
                vm.date = date
            }
            FieldView(label: "Time") {
                TimePickerFieldView(title: "Check-In", date: vm.checkInTime){ checkInTime in
                    vm.checkInTime = checkInTime
                }
                TimePickerFieldView(title: "Check-Out", date: vm.checkOutTime) { checkOutTime in
                    vm.checkOutTime = checkOutTime
                }
            }
        }
    }
}

struct HourCheckInCheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        HourCheckInCheckOutView()
            .environmentObject(PartnerHostingViewModel())
    }
}
