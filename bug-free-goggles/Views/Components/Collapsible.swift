////
//  Collapsible.swift
//  bug-free-goggles
//
//  Created by Mac on 9/3/23.
//

import SwiftUI

struct Collapsible<Content: View>: View {
    @Binding var collapsed: Bool
    @State var collapsedHeader: () -> AnyView
    @State var label: () -> Text
    @State var content: () -> Content
    let expanded: () -> Void
  
    
    var body: some View {
        VStack {
            Button(
                action: {
                    withAnimation(Animation.easeOut(duration: 0.3)) {
                        self.collapsed.toggle()
                        if !collapsed{
                            expanded()
                        }
                    }
                },
                label: {
                    if collapsed {
                        self.collapsedHeader()
                    } else{
                        HStack {
                            self.label()
                            Spacer()
                            Image(systemName:  "chevron.up" ).rotationEffect(self.collapsed ? Angle(degrees: 180) : Angle(degrees: 0))
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        .padding(.bottom,1)
                        .background(Color.white.opacity(0.01))
                   }
                    
                }
            )
            .buttonStyle(PlainButtonStyle())
            
            VStack {
                self.content()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .none)
            .clipped()
            .transition(.slide)
        }
        .background {
            Rectangle()
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.13), radius: 10, x: 0, y: 10)
            Rectangle()
                .fill(Color.white)
                .cornerRadius(10)
        }
    }
}

struct Collapsible_Previews: PreviewProvider {
    static var previews: some View {
        Collapsible(collapsed:  Binding.constant(false), collapsedHeader: {AnyView(HStack{Text("Collapsed")})} ,label: {Text("Collapsible")}, content: {Text("Content")}){
            
        }
    }
}
