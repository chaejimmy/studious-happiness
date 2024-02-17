////
//  ModalHelperView.swift
//  bug-free-goggles
//
//  Created by Mac on 02/05/23.
//

import SwiftUI

@available(OSX 10.15, *)
@available(iOS 13.0, *)

public struct ModalHelperView: View {
    
    //    MARK: - variables
    
    /// View which is presented by the modal. HalfModalContent is recommended to be used for it.
    var content: AnyView
    /// View which appears at the to ppart of the HalfModalView. It is optional.
    var header: AnyView?
    /// Decides whether the HalfModalView is presented.
    @Binding var isPresented: Bool
    
    /// The value of the modal's state: 0: closed, 1: half-opened, 2: opened.
    @State private var stateValue = 1
    
    /// The value of the drag.
    @GestureState private var translation: CGFloat = 0
    
    /// Opacity for the black background.
    @State private var backgroundOpacity = 0.0
    
    @State private var animation: Animation = .default
    
    var heightRatio: CGFloat = 0.4
    var cornerRadius: CGFloat = 0
    
    public init(content: AnyView, header: AnyView?, isPresented: Binding<Bool>, heightRatio: CGFloat = 0.4, whiteBg: Bool = false) {
        self.content = content
        self.header = header
        self._isPresented = isPresented
        self.heightRatio = heightRatio
    }
    
    //    MARK: - UI
    public var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                if isPresented {
                    Color.black
                        .opacity(self.backgroundOpacity)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 0.5)) {
                                self.isPresented = false
                            }
                        }
                }
                
                VStack(spacing: 0) {
                    self.content
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                .background(Color.clear)
                .cornerRadius(cornerRadius)
                .offset(y: self.stateValue == 1 ? geometry.size.height*heightRatio + self.translation : geometry.size.height*0.7 + self.translation)
                .animation(self.animation, value: stateValue)
                .transition(.move(edge: .bottom))
                .gesture(
                    DragGesture().updating(self.$translation) { value, state, _ in
                        if state < 0 {
                            return
                        }
                        state = value.translation.height
                    }.onEnded { value in
                        if self.stateValue == 1 && value.translation.height < -90 {
                            //                            self.stateValue = 2
                        } else if  self.stateValue == 1 && value.translation.height > 90 {
                            self.stateValue = 0
                            self.isPresented = false
                        } else if self.stateValue == 0 && value.translation.height < -90 {
                            self.stateValue = 1
                        } else if  self.stateValue == 0 && value.translation.height > 90 {
                            self.stateValue = 0
                            self.isPresented = false
                        } else if self.stateValue == 2 && value.translation.height > 90 && value.translation.height < 350 {
                            self.stateValue = 1
                        } else if  self.stateValue == 2 && value.translation.height >= 350 {
                            self.stateValue = 0
                            self.isPresented = false
                        }
                        print("State : \(stateValue)")
                    })
                
            }
        }
        .edgesIgnoringSafeArea(.all)
       
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                withAnimation {
                    self.backgroundOpacity = 0.1
                }
                self.animation = .interactiveSpring()
            }
        }
    }
}


struct SheetContent<Content> : View where Content: View {
    var bgColor: Color = Color.white
    var topCorners: (CGFloat, CGFloat) = (0, 0)
    let content: () -> Content
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                content()
                    .background(RoundedCorners(color: bgColor, tl: topCorners.0, tr: topCorners.1))
            }
        }
    }
}

struct RoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                let w = geometry.size.width
                let h = geometry.size.height
                
                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .fill(self.color)
        }
    }
}

