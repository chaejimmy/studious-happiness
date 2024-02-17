////
//  ModalExtensions.swift
//  bug-free-goggles
//
//  Created by Mac on 02/05/23.
//

import SwiftUI

extension View {
    func modal<Modal: View>(present: Binding<Bool>, view: Modal, heightRatio: CGFloat = 0, blur: Bool = false, blurRadius: CGFloat = 0) -> some View {
        self.if(blur && present.wrappedValue) {
            $0.blur(radius: blurRadius)
        }.overlay(
            ZStack {
                if present.wrappedValue {
                    ModalHelperView(content: AnyView(view), header: nil, isPresented: present, heightRatio: heightRatio)
                } else {
                    EmptyView()
                }
            }
        )
    }
    
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
