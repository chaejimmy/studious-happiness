//
//  BusinessView.swift
//  Totel (iOS)
//
//  Created by Alexander Boakye on 07/09/2023.
//

import SwiftUI

struct BusinessView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selection = 0
    @StateObject var businessVM = BusinessViewModel()
    
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
                    
                    Text("Business")
                        .font(.system(size: 28, weight: .bold))
                }
                .padding([.horizontal, .bottom])
                .padding(.bottom)
                
                SelectionView()
            }
            .background(.white)
            
            switch(BusinessTab(rawValue: selection)){
            case .earnings: EarningsView()
            case .reviews: ReviewView(businessVM: businessVM)
            case .none: EmptyView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.leading)
        .padding(.trailing)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    func SelectionView() -> some View {
        var labels: [String]{
            return BusinessTab.allCases.map{$0.title}
        }
        return CustomSegmentedControl(selection: $selection, segmentLabels: labels)
    }
}
