////
//  HourlyRoomView.swift
//  bug-free-goggles
//
//  Created by Mac on 9/10/23.
//

import SwiftUI

struct HourlyRoomView: View {
    var rooms: [HostData]
    var onTap: (_ room:HostData) -> Void
    
    var body: some View {
        
        ForEach(rooms) { room in
            HourlyRoomCell(model: room) {
                
            }
            .onTapGesture {
                onTap(room)
            }
        }
    }
}



struct HourlyRoomCell: View {
    var model: HostData
    var onReschedule: () -> Void
    
    var body: some View {
        VStack() {
            topView
            ImageSwiperView(images: model.imageUrls ?? [])
            
                .frame(height: 240)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        
            
            hotelDetailView
            
            //bottomView
        }
        .padding()
        .background(Color.background)
    }
    
    private var topView: some View {
        HStack(alignment: .top, spacing: 12) {
          
            VStack(alignment: .leading, spacing: 6) {

                Text(model.title ?? "")
                    .font(.circular(size: 16, weight: .medium))
                    .lineLimit(1)
              
            }.padding(.leading, 5)
            
            Spacer(minLength: 0)
            
            
            Button {
                // on tap more button
            } label: {
                Image("moreIcon")
            }
        }
    }
    
    private var hotelDetailView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(model.host?.lastName ?? "")
                .font(.circular(size: 16, weight: .medium))
            
            Text(model.address ?? "")
                .font(.circular(size: 13, weight: .book))
                .foregroundColor(.secondary)
                .padding(.bottom, 4)
            
          
            ViewMoreView(text: model.description ?? "")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var bottomView: some View {
        HStack {
            Text("\(model.dailyPrices?.first?.price ?? 0)")
                .font(.circular(size: 14, weight: .book))
            
            Spacer(minLength: 0)
            
            Text(model.checkInDate?.timeString ?? "")
                .font(.circular(size: 14, weight: .bold))
                .foregroundColor(Color(red: 0.263, green: 0.494, blue: 0.969))
                .padding(.horizontal, 8)
                .padding(.vertical, 3)
                .background {
                    Capsule()
                        .fill(Color(red: 0.961, green: 0.98, blue: 1))
                }
            
            Button {
                // On tap edit
                onReschedule()
            } label: {
                Image("pencil_Circle_Icon")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
        }
    }
}

struct HourlyRoomView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyRoomView(rooms: [HostData( id: "", title: "Alex Norman", description: "The two-bedroom townhome features a king bed in one bedroom and two twin beds in the other. It has 2 full bathrooms and a half bathroom, and an ample living room area. It is great for a family of 6, or even a group slightly bigger since the sofa converts into a bed. Cots can also be requested for an additional fee. This way, the whole family can stay under one roof and have the space to enjoy being together while having places to retreat to when they’ve had enough family time. The secure and beautifully-decorated 2-bedroom townhome at Encantada Resort provides many amenities that easily outshine those overpriced resorts on theme park property.", address: "CA, United States.", imageUrls: ["https://images.pexels.com/photos/6466236/pexels-photo-6466236.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load","cleanhomepic"], dailyPrices: [DailyPrice(day: "monday", price: 200, priceType: "hourly", id: "")], type: "shared-room", cleaningFee: 200, propertyType: "flat", isReported: false, bedRooms: 3, bathRooms: 2, host: Host(identityVerified: false, id: "", firstName: "Brian", lastName: "Kiragu", email: "bkiragu27@gmail.com"), whoCanStay: "male", flexibleCheckIn: true, flexibleCheckOut: true, guests: 5, latitude: 23.684994, longitude:  90.356331, beds: 1, checkInDate: Date(), checkOutDate: Date())]){ host in
            
        }
    }
}




struct ImageSwiperView: View {
    @State private var currentPage = 0
    
    let images: [String]
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<images.count, id: \.self) { index in
                    
                    ShimmeringImageView(imageURL: URL(string: images[index] ?? "")!)
                    
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .modifier(TabViewSelectionModifier(selection: $currentPage))
            
            
        }
    }
}

struct PageIndicator: View {
    @Binding var currentPage: Int
    let pageCount: Int
    
    var body: some View {
        HStack {
            ForEach(0..<pageCount, id: \.self) { index in
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(index == currentPage ? .blue : .gray)
            }
        }
    }
}



struct TabViewSelectionModifier: ViewModifier {
    @Binding var selection: Int
    
    func body(content: Content) -> some View {
        content
            .onChange(of: selection) { newValue in
                selection = newValue
            }
    }
}


struct ViewMoreView: View {
    @State private var isExpanded = false
    var text: String
        var body: some View {
        VStack(alignment: .leading) {
            Text(text)
                .lineLimit(isExpanded ? nil : 2).font(.system(size: 15, weight: .light, design: .default)).foregroundColor(.gray700)
            
            if !isExpanded {
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    Text("View More")  .font(.system(size: 13, weight: .light, design: .default))
                }
                
                
                
                
            }
        }
    }
}
