////
//  GiveAvailabilityView.swift
//  bug-free-goggles
//
//  Created by Mac on 01/06/23.
//

import SwiftUI

struct GiveAvailabilityView: View {
    @EnvironmentObject var vm: PartnerHostingViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            DayHourPickerView(picker: $vm.picker)
            if vm.picker == .hour {
                HourCheckInCheckOutView()
            }
            else {
                DayCheckInCheckOutView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct GiveAvailabilityView_Previews: PreviewProvider {
    static var previews: some View {
        GiveAvailabilityView()
            .environmentObject(PartnerHostingViewModel())
    }
}
