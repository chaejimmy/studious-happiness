////
//  GiveYourPricingView.swift
//  bug-free-goggles
//
//  Created by Mac on 13/05/23.
//

import SwiftUI

struct GiveYourPricingView: View {
    // MARK: - PROPERTIES
    @State var stepValue = 1.0
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appState: AppState
  
    // MARK: - BODY
    var body: some View {
        
        // MARK: - TOP HEADER
        VStack(alignment: .leading, spacing: 20){
            // MARK: - HEADER
            HeaderView(
                title: String.Hosting.giveYourPricePageTitle,
                subTitle: String.Hosting.giveYourPricePageSubTitle
            )
            
            // MARK: - BODY
            HStack(alignment: .center) {
               // Spacer()
                Button {
                    if stepValue > 1 {
                        stepValue -= 1
                    }
                } label: {
                    Image("minus")
                }
                
                let priceString  = String(format: "%.2f", stepValue)
                Text(String("USD $ \(priceString) / Per Day"))
                    .style(.title1)
                    .padding(15)
                    .clipShape(Capsule())
                    .background(
                        Color.primaryGray,
                        in: Capsule().stroke()
                    ).frame(minWidth: 230)
                
                Button {
                    stepValue += 1
                } label: {
                    Image("plus")
                }
                //Spacer()
            }
           // .frame(height: 50)
            //.padding()
            
            
            
            Spacer()
            
            // MARK: - BOTTOM VIEW
            HStack {
                //Back button
                BottomBackButtonView {
                    presentationMode.wrappedValue.dismiss()
                }
                
                Spacer()
                
                // Next buttons
                Button {
                    appState.shouldShowHostingView.toggle()
                    //  Text("DONE")
                } label: {
                    Text(String.Hosting.next)
                }
                .buttonStyle(secondaryButtonStyle())
                
            }//: HSTACK
            .padding(.bottom, 20)
        }
        .padding([.top, .horizontal], 16)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CircleButton(size: 40, backgroundColor: .darkWhite) {
                    IconView(image: "chevron_left", size: 24)
                } action: {
                    presentationMode.wrappedValue.dismiss()
                }
            }//: TOOL BAR ITEM
        }//: TOOLBAR
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbarBackground(Color.background, for: .navigationBar)
    }
}

struct GiveYourPricingView_Previews: PreviewProvider {
    static var previews: some View {
        GiveYourPricingView()
    }
}


struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        // 1
        Button(action: {

            // 2
            configuration.isOn.toggle()

        }, label: {
            HStack {
                // 3
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")

                configuration.label
            }
        })
    }
}
