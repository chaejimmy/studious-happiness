////
//  DatePickerSheet.swift
//  bug-free-goggles
//
//  Created by Mac on 25/05/23.
//

import SwiftUI

struct DatePickerSheet: View {
    @Environment(\.dismiss) var dismiss
    @State var date: Date = Date()
    var rangeAfterDate: Date = Date.now
    var rangeAfter: Bool = false
    let selectedDate: (Date)-> Void
    
    var body: some View {
        SheetWrapperView(onSet: { selectedDate(date) }) {
            if rangeAfter {
                DatePicker("", selection: $date, in: rangeAfterDate..., displayedComponents: .date)
                    .datePickerStyle(.graphical)
            } else {
                DatePicker("", selection: $date, in: ...Date.now, displayedComponents: .date)
                    .datePickerStyle(.graphical)
            }
        }
        .presentationDetents([.height(420)])
    }
}

struct DatePickerSheet_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerSheet(){_ in}
    }
}


struct SheetWrapperView<Content: View> : View {
    @Environment(\.dismiss) var dismiss
    let onSet: () -> Void
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack{
            content
            
            Spacer()
            HStack(spacing: 12) {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
                .buttonStyle(PrimaryButtonStyle(foregroundColor: .black, background: .darkWhite))

                Button {
                    onSet()
                    dismiss()
                } label: {
                    Text("Set")
                }
                .buttonStyle(PrimaryButtonStyle(background: .black))
            }
        }
        .background(Color.clear)
        .padding([.horizontal, .bottom], 16)
    }
}


struct TimePickerView: View {
    @State var date: Date = Date()
    let action: (Date) -> Void
    
    var body: some View {
        SheetWrapperView(onSet: { action(date) }) {
            DatePicker(
                "",
                selection: $date,
                displayedComponents: .hourAndMinute
            )
            .datePickerStyle(.wheel)
        }
        .presentationDetents([.height(300)])
    }
}
