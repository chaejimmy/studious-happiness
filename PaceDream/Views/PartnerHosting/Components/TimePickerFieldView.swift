////
//  TimePickerFieldView.swift
//  bug-free-goggles
//
//  Created by Mac on 02/06/23.
//

import SwiftUI

struct TimePickerFieldView: View {
    var title: String
    @State var date: Date = Date()
    @State private var showTimePicker: Bool = false
    let action: (Date) -> Void
    
    var body: some View {
        FieldView(label: title) {
            BorderedCapsuleButton(
                title: date.string(.hhmma, utc: false),
                trailingImage: "time",
                spacing: 24,
                horizontalPadding: 20,
                verticalPadding: 12,
                borderColor: .neutral700,
                action: {
                    showTimePicker = true
                }
            )
            .font(.inter(size: 15, weight: .medium))
        }
        .sheet(isPresented: $showTimePicker) {
            TimePickerView(date: date){
                self.date = $0
                action($0)
            }
        }
    }
}

struct TimePickerFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TimePickerFieldView(title: "Time"){_ in}
    }
}
