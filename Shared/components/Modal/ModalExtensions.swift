//
//  ModalExtensions.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 08/05/2023.
//


import SwiftUI

extension View {
    func modal<Modal: View>(present: Binding<Bool>, view: Modal, heightRatio: CGFloat = 0, blur: Bool = false, blurRadius: CGFloat = 0, opaque: Bool = false) -> some View {
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
