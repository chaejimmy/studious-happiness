//
//  EnableLocationView.swift
//  Totel
//
//  Created by Jaykrushna Solanki on 24/08/23.
//

import SwiftUI


struct EnableLocationView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var locationManager = LocationManager.shared
    @State private var shouldNavigate = false
    
    
    
    
    var body: some View {
        
        
        
        VStack{
        
            if !shouldNavigate{
                Spacer()
                
                VStack(spacing: 20.0) {
                    
                    Image("ImgLocation")
                    
                    Text("You will need to enable your location in order to looking for a partner")
                        .padding(.horizontal, 32.0)
                }
                
                Spacer()
          
                
                Button(action: {
                  
                    locationManager.requestLocationPermission()
                    locationManager.startUpdatingLocation()
                    
                }) {
                    Text("Allow Location")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 30)
                        }
                }.padding()
            }else{
                LookForView()
//                Spacer()
//                Text("Tested")
//                    .fontWeight(.medium)
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background {
//                        RoundedRectangle(cornerRadius: 30)
//                    }
//                NavigationLink {
//                    AddressDescribeView()
//                } label: {
//                    Text("Continue")
//                }
                
            }
        }
//        .navigationDestination(isPresented: $shouldNavigate) {
//            //if locationManager.userLocation != nil{
//            LookForView()
//            //}
//
//        }
//        .sheet(isPresented: $shouldNavigate) {
//                    if locationManager.userLocation != nil {
//                        LocationView()
//                    }
//                }
        .onReceive(locationManager.$userLocation) { location in
            if location != nil && !shouldNavigate{
                shouldNavigate = true
            }

        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CircleButton(size: 40, backgroundColor: .darkWhite) {
                    IconView(image: "chevron_left", size: 24)
                } action: {
                    dismiss()
                }
                
            }
        }
        .navigationBarBackButtonHidden()
        .toolbarBackground(Color.background, for: .navigationBar)
        
        
        
        
        //                            NavigationLink {
        //                                LookForView()
        //                            } label: {
        //
        //                            }
        //                            .padding()
        
        
        
        
        
    }
    
    
    //.navigationTitle("Enable Location")
}


struct EnableLocationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EnableLocationView()
        }
    }
}
