//
//  SpaceView.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 06/09/2023.
//

import SwiftUI

struct SpaceView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selection = 0
    @StateObject var spaceVM = SpaceViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                VStack(alignment: .leading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 10, height: 10)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color("DarkWhite"))
                            .clipShape(Circle())
                    }
                    
                    Text("Space")
                        .font(.system(size: 28, weight: .bold))
                    
                }
                .padding(selection == 0 ? [.horizontal] : [.horizontal, .bottom])
                .padding(selection != 0 ? .bottom : .trailing)
                
                if selection == 0 {
                    HStack {
                        Spacer()
                        Button {
                            
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "plus.circle")
                                Text("Post new")
                            }
                        }
                        
                    }
                    .padding([.bottom, .trailing])
                }
                
                SelectionView()
                    
            }
            .background(.white)
            
            switch(SpaceTab(rawValue: selection)){
            case .listings: ListingsView(spaceVM: spaceVM).padding(.horizontal)
            case .claims: ClaimsView(spaceVM: spaceVM).padding(.horizontal)
            case .none: EmptyView()
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
    }
    func SelectionView() -> some View {
        var labels: [String]{
            return SpaceTab.allCases.map{$0.title}
        }
        return CustomSegmentedControl(selection: $selection, segmentLabels: labels)
    }
    
}

