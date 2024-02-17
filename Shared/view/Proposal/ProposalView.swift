
//
//  ProposalView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 13/05/2023.
//



import SwiftUI

struct ProposalView : View {
    @ObservedObject var proposalVM = ProposalViewModel()

    @Environment(\.presentationMode) var presentationMode

    @FocusState var searchFocused: Bool
    @State var searchAnimation: Bool = false


    var body: some View {
        GeometryReader { geometry in
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
                        

                    
                       ZStack(alignment: .leading) {
                           switch proposalVM.currentView {
                           case 0: AvailbiltyView()
                           case 1: PricingView()
                           case 2: BookedTypeView()
                           case 3: BookedRoomView()
                           case 4: LocationView()
                           case 5: ShareableDetailView()
                           case 6: AmentitiesView()
                           case 7: UploadImageView()
                           case 8: HouseTitleView()

                           default: AvailbiltyView()
                           }
                       }
                       
                       Spacer()
                       
                       HStack {
                           
                           Button {
                               
                               proposalVM.goPreviousView()
                           } label: {
                               HStack(spacing: 10) {
                                   Text("Back")
                                       .foregroundColor(.black)
                               }
                           }
                           .frame(width: 100)
                           .buttonStyle(PrimaryButtonStyle(background: .darkWhite))

                           Spacer()
                           
                           Button {
                               proposalVM.goNextView()

                           } label: {
                               HStack(spacing: 10) {
                                   
                                   Text("Next")
                               }
                           }
                           .frame(width: 100)

                           .buttonStyle(PrimaryButtonStyle(background: .appPrimary))
                       }
                       .padding(.trailing)
                       
                   }
                   .padding(.leading) // Add left
                   .navigationBarBackButtonHidden(true)
                   .navigationBarHidden(true)
                   .partialSheet(isPresented: $proposalVM.isCheckInCalender,
                                 content: CalendarView.init)
                   
                   .partialSheet(isPresented: $proposalVM.isCheckOutCalender,
                                 content: CalendarView.init)

        }
    }
    
    func DayView() -> some View {
        VStack(alignment:.leading) {

            Text("Date")
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(Color("993C3C43"))
                .padding(.top,10)
                .padding(.leading,5)
            
            DaySelectionView(type: 0,title: "06/13/2023 - 08/13/2023 ")
                .frame(width: 250)
            
         
            
        }
        .padding(.top,10)
    }
    
    
    func HourView() -> some View {
        VStack(alignment:.leading) {

            Text("Date")
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(Color("993C3C43"))
                .padding(.top,10)
                .padding(.leading,5)
            
            DaySelectionView(type: 0,title: "06/13/2023")
                .frame(width: 150)

            
            Text("Time")
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(Color("993C3C43"))
                .padding(.top,10)
                .padding(.leading,5)
            
            HourSelectionView()
                .frame(width: 230)

            
        }
        .padding(.top,10)
    }
    
    
    
    func DaySelectionView(type: Int, title: String) -> some View {
        Button(action: {
            
            print("type \(type)")
            if type == 0{
                proposalVM.isCheckInCalender = true;
                proposalVM.isCheckOutCalender = false;

                
            }else{
                proposalVM.isCheckOutCalender = true;
                proposalVM.isCheckInCalender = false;

                
            }
            
        }) {
            HStack(spacing: 0) {
                Text(title)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color("272D37"))
                Spacer()
                Image("calendarIcon")
                    .frame(width: 20, height: 20)
            }
            .padding(.horizontal)
            .padding(.vertical, 13)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color("DAE0E6"), lineWidth: 1) // Set the border color and width
                    )
            )
        }
        .foregroundColor(Color("DAE0E6"))
    }
    
    
    
    func HourSelectionView() -> some View {
        Button(action: {}) {
            HStack(spacing: 0) {
                Text("08:00 AM - 12:00 AM")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color("272D37"))
                Spacer()
                Image("time")
                    .frame(width: 20, height: 20)
            }
            .padding(.horizontal)
            .padding(.vertical, 13)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color("DAE0E6"), lineWidth: 1) // Set the border color and width
                    )
            )
        }
        .foregroundColor(Color("DAE0E6"))
    }
    

    
    
    func AvailbiltyView() -> some View {
        VStack (alignment: .leading){
            Text("Give your availability")
                .font(.system(size: 28, weight: .bold))
                .padding(.top,10)
                .padding(.leading,5)
            
            Text("In this step, we'll ask you which type of stays you have and if guests will book the entire place or just a \nroom.")
                .font(.system(size: 15))
                .padding(.top,2)
                .padding(.leading,5)
            
            HStack(spacing: 12) {
                ForEach(TimeType.allCases, id: \.title) { time in
                    ChipView(
     
                        title: time.title,
                        bgColor: Color("purple"),
                        unBgColor: Color.white,
                        unSelectedTextCoor: Color("49556D"),
                        isSelected: proposalVM.selectedTime == time
                    ) {
                        withAnimation(.easeInOut) {
                            proposalVM.selectedTime = time
                        }
                    }
                }
            }
            .padding(.top,15)
            
            
            ZStack {
                switch proposalVM.selectedTime {
                case TimeType.day: DayView()
                case TimeType.hour: HourView()
                }
            }
        }
    }
    
    
    
    func PricingView() -> some View {
        VStack(alignment: .leading) {
            Text("Give your pricing")
                .font(.system(size: 28, weight: .bold))
                .padding(.top,10)
                .padding(.leading,5)
            
            Text("In this step, we'll ask you which type of stays you have and if guests will book the entire place or just a \nroom.")
                .font(.system(size: 15))
                .padding(.top,2)
                .padding(.leading,5)
            
            CounterWidget()
                .padding(.top, 15)

            
            
            Text("His Bid rate is $75 to $90")
                .font(.system(size: 15))
                .foregroundColor(Color("919BA7"))
                .padding(.leading,5)
                .padding(.top,5)

        }
    }
    
    
    func BookedTypeView() -> some View {
        VStack(alignment: .leading) {
            Text("Which of these best \ndescribes your booked \nroom?")
                .font(.system(size: 28, weight: .bold))
                .padding(.top,10)
                .padding(.leading,5)
            
            Text("In this step, we'll ask you which type of stays you have and if guests will book the entire place or just a \nroom.")
                .font(.system(size: 15))
                .padding(.top,2)
                .padding(.leading,5)
            
            
            RoomGridView(selectedPlace: $proposalVM.selectedPlaces)
            

        }
    }
    
    
    func BookedRoomView() -> some View {
        VStack(alignment: .leading) {
            Text("Which of these best \ndescribes your booked \nroom?")
                .font(.system(size: 28, weight: .bold))
                .padding(.top,10)
                .padding(.leading,5)
            
            Text("In this step, we'll ask you which type of stays you have and if guests will book the entire place or just a \nroom.")
                .font(.system(size: 15))
                .padding(.top,2)
                .padding(.leading,5)
            
            
            
            HStack(spacing: 12) {
                ForEach(RoommType.allCases, id: \.data.title) { room in
                    ChipView(
                        title: room.data.title,
                        bgColor: .appPrimary,
                        unBgColor: Color("DarkWhite"),
                        unSelectedTextCoor: .black,
                        isSelected: proposalVM.selectedRoom == room,
                        showImage:true,
                        imagePath: room.data.image
                        
                    ) {
                        withAnimation(.easeInOut) {
                            proposalVM.selectedRoom = room
                        }
                    }
                }
            }
            .padding(.top,15)
            

        }
    }
    
    
    func LocationView() -> some View {
        VStack(alignment: .leading) {
            Text("Where's your place located?")
                .font(.system(size: 28, weight: .bold))
                .padding(.top,10)
                .padding(.leading,5)
            
            
            
            Text("In this step, we'll ask you which type of stays you have and if guests will book the entire place or just a \nroom.")
                .font(.system(size: 15))
                .padding(.top,2)
                .padding(.leading,5)
            
            
            HStack {
                Image("map")
                    .frame(width: 24, height: 24)
                TextField("enter location", text: $proposalVM.searchText)
                    .focused($searchFocused)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 18)
            .background {
                Capsule()
                    .fill(Color.lightGray)
                    .overlay {
                        Capsule()
                            .stroke(style: StrokeStyle(lineWidth: searchAnimation ? 1 : 0))
                            .foregroundColor(.appPrimary)
                    }
                    .padding(.vertical, 0.5)
            }
            .onTapGesture {
                searchToggle(isShow: true)
            }
            .padding(.trailing,20)
            .padding(.top,5)
            
            
            GoogleMapView()
                .frame(height: 500)
                .cornerRadius(10)
                .padding(.trailing,20)
                .padding(.top,5)




        }
    }

    func searchToggle(isShow: Bool = false){
        withAnimation(.easeInOut(duration: 0.5)) {
            searchAnimation = isShow
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            searchFocused = isShow
        }
    }
    
    
    func ShareableDetailView() -> some View {
        VStack(alignment: .leading) {
            Text("Who will share the room?")
                .font(.system(size: 28, weight: .bold))
                .padding(.top,10)
                .padding(.leading,5)
            
            Text("In this step, we'll ask you which type of stays you have and if guests will book the entire place or just a \nroom.")
                .font(.system(size: 15))
                .padding(.top,2)
                .padding(.leading,5)
            
            
            
            HStack(spacing: 12) {
                ForEach(PersonType.allCases, id: \.data.title) { room in
                    ChipView(
                        title: room.data.title,
                        bgColor: .appPrimary,
                        unBgColor: Color("DarkWhite"),
                        unSelectedTextCoor: .black,
                        isSelected: proposalVM.selectedPersonType == room,
                        showImage:true,
                        imagePath: room.data.image
                        
                    ) {
                        withAnimation(.easeInOut) {
                            proposalVM.selectedPersonType = room
                        }
                    }
                }
            }
            .padding(.top,15)
            
            
            Text("Sharable Details")
                .font(.system(size: 15))
                .foregroundColor(Color("919BA7"))
                .padding(.leading,5)
                .padding(.top,20)
            
            
            
            ForEach(roomItems, id: \.self) { item in
                          RoomItemWidget(title: item, index: "1")
                       }
            .padding(.top,7)

        }
    }
    
    
    
    func AmentitiesView() -> some View {
        VStack(alignment: .leading) {
            Text("What are the amenities")
                .font(.system(size: 28, weight: .bold))
                .padding(.top,10)
                .padding(.leading,5)
           
            
            Text("that room have have?")
                .font(.system(size: 28, weight: .bold))
                .padding(.leading,5)

            Text("In this step, we'll ask you which type of stays you have and if guests will book the entire place or just a \nroom.")
                .font(.system(size: 15))
                .padding(.top,2)
                .padding(.leading,5)

            
            AmentitesGridView(selectedPlace: $proposalVM.selectedAmentities)
                .padding(.top,2)

            
            
            Text("Any standout amenities?")
                .font(.system(size: 13, weight:  .bold))
                .foregroundColor(Color("993C3C43"))
                .padding(.top,2)
                .padding(.leading,5)
            
            StandardAmentitesGridView(selectedPlace: $proposalVM.selectedStandardAmentities)
                .padding(.top,2)

            



        }
    }
    
    
    func UploadImageView() -> some View {
        VStack(alignment: .leading) {
            Text("Upload Images")
                .font(.system(size: 28, weight: .bold))
                .padding(.top,10)
                .padding(.leading,5)
           

            Text("Choose at least 6 pictures.")
                .font(.system(size: 15))
                .padding(.top,2)
                .padding(.leading,5)

            
            Button {
                proposalVM.openImagePicker(isPickFromGallery: true)
            } label: {
                RoundedRectangle(cornerRadius: 10)
                          .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                          .foregroundColor(.gray)
                          .padding(.top,5)

                          .overlay(
                            VStack {
                                
                                ZStack {
                                            Circle()
                                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                                                .foregroundColor(.gray)
                                                .frame(width: 40, height: 40)

                                            Image(systemName: "plus")
                                                .font(.system(size: 18))
                                                .foregroundColor(.black)
                                        }
                                .frame(width: 40, height: 40)
                                .padding(.top,5)

                                
                                Text("Add Images")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(Color("272D37"))
                                    .padding(.top,5)
                                    .padding(.bottom,3)
                                
                                
                                HStack {
                                    
                                    Text("Browse Files")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(Color("purple"))
                                    
                                    
                                    Text("from gallery")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(Color("5F6D7E"))
                                    
                                }
                        
                                
                                
                            }
                          )
                          .padding(.leading,5)
                          .frame(height:150)
            }
            
            GeometryReader { geometry in
                if proposalVM.imageGallery.isEmpty {
                    Text("No images available")
                        .foregroundColor(.gray)
                } else {
                    List {
                        ForEach(proposalVM.imageGallery, id: \.self) { image in
                            ZStack {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: geometry.size.width, height: 215)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                
                                VStack {
                                    HStack {
                                        Spacer()
                                        
                                        Image(systemName: "xmark")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 17, height: 17)
                                            .foregroundColor(.black)
                                            .padding()
                                            .clipShape(Circle())
                                            .background(Color.white)
                                        
                                            .padding(1)
                                        .background(Color.white)
                                        .clipShape(Circle())
                                        .offset(x: -8, y: -8)
                                    }
                                    .padding(.top,20)

                                    Spacer()
                                }
                            }


                            .padding(.top,10)
                            .listRowInsets(EdgeInsets()) // Remove left padding
                        }
                    }
                    .listStyle(.plain)
                    .listRowBackground(Color.clear)

                }
            }




            
        }
        .padding(.trailing,20)
        .sheet(isPresented: $proposalVM.openChooserSheet, onDismiss: {
            proposalVM.showPhotoPicker = false
        }){
            ImagePicker(sourceType: proposalVM.isPickFromGallery ? .photoLibrary : .camera, selectedImage: $proposalVM.image){ image in
                proposalVM.storeImage(image: image)
            }
        }
    }
    
    
    
    func HouseTitleView() -> some View {
        VStack(alignment: .leading) {
            Text("Let's give your house a title")
                .font(.system(size: 28, weight: .bold))
                .padding(.top,10)
                .padding(.leading,5)
           
            
            Text("Short titles work best. Have fun with it – you can always change it later.")
                .font(.system(size: 15))
                .padding(.top,2)
                .padding(.leading,5)

            
            Text("Heading")
                .font(.system(size: 13, weight:  .bold))
                .foregroundColor(Color("993C3C43"))
                .padding(.top,5)
                .padding(.leading,5)
            
            
            
            TextField("enter your title here", text: $proposalVM.titleText)
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.black)
                .frame(minHeight: 15)
                .padding()
                .multilineTextAlignment(.leading)
            
                .background {
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.lightGray)
                    
                    
                }
                .padding(.top,2)

                .padding(.leading,5)
                .padding(.trailing, 20)

            
            Text("Note")
                .font(.system(size: 13, weight:  .bold))
                .foregroundColor(Color("993C3C43"))
                .padding(.top,5)
                .padding(.leading,5)
                .padding(.trailing, 20)

            
            
            
            TextField("enter your note here", text: $proposalVM.noteText)
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.black)
                .frame(minHeight: 120)
                .padding()
                .multilineTextAlignment(.leading)
            
                .background {
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.lightGray)
                }
            
                .padding(.top,2)

                .padding(.leading,5)
                .padding(.trailing, 20)
            



        }
    }
    
}









