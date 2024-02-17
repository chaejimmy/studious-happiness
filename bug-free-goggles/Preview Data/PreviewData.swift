////
//  PreviewData.swift
//  bug-free-goggles
//
//  Created by Mac on 11/05/23.
//

import Foundation

class PreviewData {
    static let hotelDesciptions: [KeyValueModel] = [
        KeyValueModel(key: "Rent", value: "$920/night"),
        KeyValueModel(key: "Duration", value: "14 Feb - 16 Feb"),
        KeyValueModel(key: "Time", value: "10:50 - 19:20 Each Day"),
        KeyValueModel(key: "Feature", value: "Free Wifi \nPets Accepted \nGym \nEn-suite available \nRemote viewing available \nCommunal living room")
    ]
    
    static let userDescriptions: [KeyValueModel] = [
        KeyValueModel(key: "Gender", value: "Female"),
        KeyValueModel(key: "Age", value: "24 Years"),
        KeyValueModel(key: "Occupation", value: "Student"),
        KeyValueModel(key: "Interests", value: "🌈 LGBT+ friendly \n 🐱 Has a cat \n🙌 Interested in teaming-up"),
        KeyValueModel(key: "Languages", value: "English, Japanese")
    ]
    
    static let compatibleDescs: [KeyValueModel] = [
        KeyValueModel(key: "Gender", value: "Male & Female"),
        KeyValueModel(key: "Age", value: "Between 18 to 32 Years old"),
        KeyValueModel(key: "Occupation", value: "Student & Professionals"),
        KeyValueModel(key: "Pets", value: "Pets & No Pets"),
    ]
    
    static let basicInfo: [KeyValueModel] = [
        KeyValueModel(key: "Budget", value: "$820-$1000/Night"),
        KeyValueModel(key: "Available", value: "from 20th March, 2023"),
        KeyValueModel(key: "Looking Near", value: "Bristol \nNottingham \nBath \nLondon \nNorthampton")
    ]
    
    // BookingData
    
    static let bookingData = BookingData(id: "1", user: "263712767362", room: "12688", wishlist: "231527161", checkInDate: "2023-05-10T00:00:00.000Z", checkOutDate: "2023-06-15T00:00:00.000Z", status: "active", createdAt: "2023-05-05T19:38:50.690Z", payment: paymentData, roomData: roomData, roomMateData: roomMateData)
    
    static let paymentData = PaymentData(amount: 500, currency: "USD", paymentMethod: "credit_card", paymentStatus: "paid")
    
    static let locationData = LocationData(type: "Point", name: "Room 1", coordinates: CoordinateData(latitude: 51.507222, longitude: -0.1275))
    
    static let roomData = RoomData(id: "23842632783", roomNumber: 123, roomName: "Brunel's SS Great Britain", lookingPlaces: "Bristol, Bath & London", reserveFrom: Date.fromString("2025-05-01T00:00:00.000Z"), reserveTo: Date.fromString("2025-07-01T00:00:00.000Z"), roomType: "standard", roomDescription: "fully furnished room.", roomStatus: "vacant", roomPrice: 1300, roomFeatures: ["Wi-Fi"], images: imageDatas, location: locationData)
    
    static let roomMateData = RoommateData(
        id: "3238263", firstName: "Stella", lastName: "Williams", email: "stella@gmail.com", gender: "Female",
        images: imageDatas,
        bio: "Hi there! I’m creative individual who loves to spend time outdoors and explore new places. I work as a graphic designer and enjoy spending my free time drawing and painting.",
        occupation: "Student",
        interests: "🌈 LGBT+ friendly\n 🐱 Has a cat\n 🙌 Interested in teaming-up",
        language: "English, Japanese", memberSince: Date.fromString("2023-05-02T21:58:12.513Z") ?? Date(),
        user: "362868236273", room: "23482379", city: "Bristol", country: "United Kingdom")
    
    static let imageDatas =  [
        ImageData(
            id: "0",
            url: "https://res.cloudinary.com/dxqeedmxk/image/upload/v1683613799/Reviews/plw1zi7ilulcb7nbf19h.jpg",
            publicId: "0"
        ),
        ImageData(
            id: "1",
            url: "https://res.cloudinary.com/dxqeedmxk/image/upload/v1684402185/Reviews/avblo8tlxhpvs4dabv21.png",
            publicId: "1"
        ),
        ImageData(
            id: "2",
            url: "https://res.cloudinary.com/dxqeedmxk/image/upload/v1684402184/Reviews/fd2qlauzo0oqamltmoxw.png",
            publicId: "2"
        )
    ]
    
    static let phoneReq = PhoneSignUpRequest(mobile: "+918701337970", email: "abc@gmail.com", firstName: "John", lastName: "Bond", password: "1111111", birthDate: "12-02-1996", gender: "Male")
}
