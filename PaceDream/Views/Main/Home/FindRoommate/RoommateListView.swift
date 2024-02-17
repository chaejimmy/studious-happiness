////
//  RoommateListView.swift
//  bug-free-goggles
//
//  Created by Mac on 9/16/23.
//

import SwiftUI


import SwiftUI

struct RoommateListView: View {
//    @EnvironmentObject var routerPath: RouterPath
         
    let roommates:  [Roommate] = [
        Roommate(id: 3, name: "Rachel Brown", image: "person1", isWishlist: true),
        Roommate(id: 4, name: "Max Geller", image: "person2", isWishlist: true),
        Roommate(id: 5, name: "Steve McQueen", image: "person3", isWishlist: false),
        Roommate(id: 6, name: "Ilia Aziz", image: "person4", isWishlist: true),
//        Roommate(id: 1, name: "Reserved Home 1", image: "moc_hotel", isWishlist: false),
//        Roommate(id: 2, name: "Reserved Home 2", image: "onboard3", isWishlist: false),
//        Roommate(id: 2, name: "Reserved Home 2", image: "onboard3", isWishlist: false),
//        Roommate(id: 2, name: "Reserved Home 2", image: "onboard3", isWishlist: false),

    ]
    
    @ViewBuilder
    var noWishListview: some View {
        VStack(spacing: 5) {
            Image("wishlistIcon")
                .resizable()
                .frame(width: 70, height: 70)
            Text("No wishlists yet")
                .font(.title2)
                .bold()
            
        }
        
    }
   
    @Binding var navigation: Bool
    var onTap: () -> Void
    var body: some View {
        if  roommates.isEmpty {
            noWishListview
                .frame(alignment: .center)
        } else {
            VStack {
                ScrollView(showsIndicators: false){
                    LazyVGrid(columns:  Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 15) {
                        ForEach(roommates) { home in
                            RoommateCardView(home: home)
                                .onTapGesture {
                                    onTap()
//                                    navigation.toggle()
                                }
                        }
                    }
                }
                
            }.padding(5)
        }
    }
}

struct Roommate: Identifiable {
    let id: Int
    let name: String
    let image: String
    let isWishlist: Bool
}

struct RoommateCardView: View {
    let home: Roommate // Assuming `Home` is the data model for the listing
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(home.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .frame(height: 250)
                .clipped()
                
//                .clipShape(
//                                RoundedRectangle(cornerRadius: 12, corners: [.topLeft, .topRight])
//                            )
            
            VStack(alignment: .leading){
                HStack {
                    Text(home.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                   
                    Image("tickIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width:15 ,height: 15)
                        .clipped()
                }
                
                // Text S/Medium
                Text("23 Years / Male")
                  .font(
                    Font.custom("Inter", size: 15)
                      .weight(.medium)
                  )
                  .foregroundColor(.black)
                
                Text("Looking Near: Bristol, Bath & London")
                  .font(Font.custom("Inter", size: 15))
                  .foregroundColor(Color(red: 0.15, green: 0.18, blue: 0.22))
                  .frame(maxWidth: .infinity, alignment: .topLeading)
                
            }.padding(.horizontal)
             .padding(.vertical,10)
            
            
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.gray.opacity(0.3), radius: 8, x: 0, y: 4)
    }
}

struct RoommateListView_Previews: PreviewProvider {
    static var previews: some View {
        RoommateListView(navigation: .constant(true)){
            
        }
    }
}

struct GridRoomItemModel: Identifiable {
    let id = UUID()
    let imageName: String
}

struct GridRoomItemView: View {
    let model: GridRoomItemModel
    @Binding var selectedItem: GridRoomItemModel?
    
    var body: some View {
        Image(model.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(10)
            .padding(10)
            .onTapGesture {
                selectedItem = model
            }
    }
}

struct GridRoomDetailView: View {
    let model: GridRoomItemModel
    @Binding var selectedItem: GridRoomItemModel?
    
    var body: some View {
        Image(model.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            .onAppear {
                withAnimation {
                    selectedItem = nil
                }
            }
    }
}

struct GridRoomView: View {
    let gridItems: [GridRoomItemModel] = [
        GridRoomItemModel(imageName: "room1"),
        GridRoomItemModel(imageName: "room2"),
        GridRoomItemModel(imageName: "room3"),
        GridRoomItemModel(imageName: "room4"),
        GridRoomItemModel(imageName: "room5"),
        GridRoomItemModel(imageName: "room6"),
    ]
    
    @State private var selectedItem: GridRoomItemModel? = nil
    @State private var isDetailActive: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)], spacing: 10) {
                    ForEach(gridItems) { item in
                        GridRoomItemView(model: item, selectedItem: $selectedItem)
                            .onTapGesture {
                                selectedItem = item
                                isDetailActive = true
                            }
                    }
                }
                .padding()
            }
            .background(
                NavigationLink("", destination: GridRoomDetailView(model: selectedItem ?? gridItems[0], selectedItem: $selectedItem), isActive: $isDetailActive)
            )
            .navigationTitle("Grid Rooms")
        }
    }
}
