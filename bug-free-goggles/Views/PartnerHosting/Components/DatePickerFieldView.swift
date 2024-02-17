////
//  DatePickerFieldView.swift
//  bug-free-goggles
//
//  Created by Mac on 02/06/23.
//

import SwiftUI

struct DatePickerFieldView: View {
    var title: String
    @State var date: Date = Date()
    @State private var showDatePicker: Bool = false
    var rangeAfterDate: Date = Date()
    let action: (Date) -> Void
    
    var body: some View {
        FieldView(label: title) {
            BorderedCapsuleButton(
                title: date.string(.ddMMyyyySlashed, utc: false),
                trailingImage: "calendar",
                spacing: 24,
                horizontalPadding: 20,
                verticalPadding: 12,
                borderColor: .neutral700,
                action: {
                    showDatePicker = true
                }
            )
            .font(.inter(size: 15, weight: .medium))
        }
        .sheet(isPresented: $showDatePicker) {
            DatePickerSheet(date: date, rangeAfterDate: rangeAfterDate, rangeAfter: true){
                self.date = $0
                action($0)
            }
        }
    }
}
struct DatePickerFieldView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerFieldView(title: "Date"){_ in }
    }
}
