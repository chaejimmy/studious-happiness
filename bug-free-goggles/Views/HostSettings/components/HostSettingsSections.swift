//
//  HostSettingsSections.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 06/09/2023.
//

import SwiftUI

struct HostSettingsSections: View {
    let sectionName: String
    let sectionImage: String
    let  selected: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            Image(sectionImage)
                .renderingMode(.template)
                .foregroundColor(selected ? .appBlue : Color(red: 0.65, green: 0.65, blue: 0.65))
            
            Text(sectionName)
                .fontWeight(.medium)
                .foregroundColor(selected ? .appBlue : .black)
            
            Spacer()
        }
        .padding(.leading, 67)
    }
}
