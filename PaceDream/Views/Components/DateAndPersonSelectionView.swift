////
//  DateAndPersonSelectionView.swift
//  bug-free-goggles
//
//  Created by Mac on 05/05/23.
//

import SwiftUI

struct DateAndPersonSelectionView: View {
    var showLabel: Bool = false
    let dateAction: () -> Void
    let personsAction: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            VStack {
                if showLabel {
                    Text("Check In - Check Out")
                        .font(.system(size: 15, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Button(action: dateAction) {
                    HStack(spacing: 0) {
                        Text("28 Apr - 08 May, 2023")
                            .font(.system(size: 17, weight: .regular))
                        Spacer()
                        Image("calendarIcon")
                            .frame(width: 20, height: 20)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 13)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.lightGray)
                    )
                }
                .foregroundColor(.black)
            }
            .fixedSize(horizontal: false, vertical: true)
            VStack {
                if showLabel {
                    Text("Person")
                        .font(.system(size: 15, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Button(action: personsAction) {
                    HStack(spacing: 0) {
                        Text("1, 2")
                            .font(.system(size: 17, weight: .regular))
                        Spacer(minLength: 16)
                        Image("personsIcon")
                            .frame(width: 20, height: 20)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 13)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.lightGray)
                    )
                }
                .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .fixedSize()
        }
    }
}

struct DateAndPersonSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        DateAndPersonSelectionView(dateAction: {}, personsAction: {})
    }
}
