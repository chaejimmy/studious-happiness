////
//  NavScrollView.swift
//  bug-free-goggles
//
//  Created by Mac on 09/05/23.
//


import SwiftUI

struct NavScrollView<Content: View>: View {
    let title: String
    let leftAction: () -> Void
    var content: () -> Content
    
    @State var offset: CGFloat = 0
    // Start offset
    @State var startOffset: CGFloat = 0

    // To move title to center were getting the title width
    @State var titleOffset: CGFloat = 0
    
    // To get the scrollview padded from the top we're going to get the height of the title bar
    @State var titleBarheight: CGFloat = 0
    @State var onAppear = false
    
    
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack(alignment: .leading, spacing: 0) {
                if offset < 60 {
                    VStack(alignment: .leading, spacing: 16) {
                        Button {
                            leftAction()
                        } label: {
                            Image("arrowBackIcon")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .padding(14)
                                .background(Color.darkWhite)
                                .clipShape(Circle())
                            
                        }
                        .padding(.leading)
                        
                        Text(title)
                            .font(.system(size: 28, weight: offset > 60 ? .semibold : .bold))
                            .overlay(
                                GeometryReader { geometry -> Color in
                                    let width = geometry.frame(in: .global).maxX
                                    DispatchQueue.main.async {
                                        // Store
                                        if titleOffset == 0 {
                                            titleOffset = width
                                        }
                                    }
                                    return Color.clear
                                }
                                    .frame(width: 0, height: 0)
                            )
                            .padding(.horizontal)
                            .padding(.bottom)
                        // Scaling
                            .scaleEffect(getScale)
                        // Getting offset and moving the view
                            .offset(getOffset)
                    }
                } else {
                    HStack(spacing: 12) {
                        Button {
                            leftAction()
                        } label: {
                            Image("arrowBackIcon")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .padding(8)
                            
                        }
                        .padding(.leading)
                        Text(title)
                            .font(.system(size: 17, weight: .semibold))
                    }
                    .padding(.vertical, 8)
                    Divider()
                        .background(Color.darkWhite)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .zIndex(1)
            .animation(.easeInOut(duration: 0.3), value: offset)
            .background(
                ZStack {
                    if offset < 60 {
                        Color.clear
                    } else {
                        Color.white
                    }
                }
                .ignoresSafeArea()
            )
            .if(onAppear) {
                $0.overlay(
                    GeometryReader { geometry -> Color in
                        let height = geometry.frame(in: .global).maxY
                        DispatchQueue.main.async {
                            if titleBarheight == 0 {
                                titleBarheight = height - (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
                            }
                        }
                        return Color.clear
                    }
                )
            }
            ScrollView(.vertical, showsIndicators: false) {
                content()
                    .padding(.top, titleBarheight)
                    .if(onAppear) {
                        $0.overlay(
                            GeometryReader { geometry -> Color in
                                let minY = geometry.frame(in: .global).minY
                                DispatchQueue.main.async {
                                    // To get original offset
                                    // ie from 0
                                    // just minus start offset
                                    if startOffset == 0 {
                                        startOffset = minY
                                    }
                                    offset = startOffset - minY
                                }
                                return Color.clear
                            }.frame(width: 0, height: 0),
                            alignment: .top
                        )
                    }
            }
        }
        .onAppear() {
            DispatchQueue.main.async {
                onAppear = true
            }
        }
    }
    
    var getOffset: CGSize {
        var size: CGSize = .zero
        let screenWidth = UIScreen.main.bounds.width / 2
        // Since width is slow we're multiplying with 1.5
        size.width = offset > 0 ? (offset * 0.65   <= (screenWidth - titleOffset) ? offset * 0.65 : (screenWidth - titleOffset)) : 0
        size.height = offset > 0 ? (offset < 60 ? -offset : -60) : 0
        return size
    }

    var getScale: CGFloat {
        if offset > 0 {
            let screenWidth = UIScreen.main.bounds.width
            let progress = 1 - (getOffset.width / screenWidth)
            return progress >= 0.9 ? progress : 0.6
        } else {
            return 1
        }
    }
}
struct NavScrollView_Previews: PreviewProvider {
    static var previews: some View {
        NavScrollView(title: "Profile", leftAction: {}) {
            VStack(spacing: 15) {
                ForEach(1...20, id: \.self) { i in
                    Text("\(i)")
                        .frame(maxWidth: .infinity)
                        .padding()
                }
            }
            .padding(.top, 10)
        }
    }
}
