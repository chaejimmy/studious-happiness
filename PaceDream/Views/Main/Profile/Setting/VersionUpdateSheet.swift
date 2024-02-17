////
//  VersionUpdateSheet.swift
//  bug-free-goggles
//
//  Created by Mac on 24/05/23.
//

import SwiftUI

struct VersionUpdateSheet: View {
    let title: String
    let description: String
    let dismissAction: () -> Void
    
    var body: some View {
        SheetContent {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Version")
                        .font(.system(size: 17, weight: .semibold))
                    Spacer()
                    CloseButtonView {
                        dismissAction()
                    }
                }
                
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .padding(.top, 12)
                
                Text(description)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.secondaryGray)
                    .padding(.top, 4)
                
                Button {
                    dismissAction()
                } label: {
                    Text("Update Now")
                }
                .buttonStyle(PrimaryButtonStyle())
                .padding(.top, 12)
                
                Button {
                    dismissAction()
                } label: {
                    Text("No, thanks")
                }
                .buttonStyle(PrimaryButtonStyle(foregroundColor: .black, background: .darkWhite))
            }
            .padding()
            .padding(.bottom)
        }
    }
}

struct VersionUpdateSheet_Previews: PreviewProvider {
    static var previews: some View {
        VersionUpdateSheet(
            title: "Using Now V 1.2.3.0",
            description: "Totel recommends that you update to the the latest version or a seamless enhanced performance of the app."
        ){}
    }
}
