////
//  HostData.swift
//  bug-free-goggles
//
//  Created by Mac on 9/9/23.
//

import Foundation

public struct HostData: Codable, Identifiable, Equatable, Hashable{

    public let id: String
    let title, description, address: String?
    let imageUrls: [String]?
    let dailyPrices: [DailyPrice]?
    let type: String?
    let cleaningFee: Int?
    let propertyType: String?
    let isReported: Bool?
    let bedRooms, bathRooms: Int?
    let host: Host?
    let whoCanStay: String?
    let flexibleCheckIn, flexibleCheckOut: Bool?
    let guests: Int?
    let latitude, longitude: Double?
    let beds: Int?
    let checkInDate, checkOutDate: Date?


    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title, description, address, imageUrls, dailyPrices, type, cleaningFee, propertyType, isReported, bedRooms, bathRooms, host, whoCanStay, flexibleCheckIn, flexibleCheckOut, guests, latitude, longitude, beds
        case checkInDate
               case checkOutDate

    }
    
    init(id: String, title: String, description: String, address: String, imageUrls: [String], dailyPrices: [DailyPrice], type: String, cleaningFee: Int, propertyType: String, isReported: Bool, bedRooms: Int, bathRooms: Int, host: Host, whoCanStay: String, flexibleCheckIn: Bool, flexibleCheckOut: Bool, guests: Int, latitude: Double, longitude: Double, beds: Int, checkInDate: Date, checkOutDate: Date) {
           self.id = id
           self.title = title
           self.description = description
           self.address = address
           self.imageUrls = imageUrls
           self.dailyPrices = dailyPrices
           self.type = type
           self.cleaningFee = cleaningFee
           self.propertyType = propertyType
           self.isReported = isReported
           self.bedRooms = bedRooms
           self.bathRooms = bathRooms
           self.host = host
           self.whoCanStay = whoCanStay
           self.flexibleCheckIn = flexibleCheckIn
           self.flexibleCheckOut = flexibleCheckOut
           self.guests = guests
           self.latitude = latitude
           self.longitude = longitude
           self.beds = beds
           self.checkInDate = checkInDate
           self.checkOutDate = checkOutDate
       }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.address = try container.decodeIfPresent(String.self, forKey: .address)
        self.imageUrls = try container.decodeIfPresent([String].self, forKey: .imageUrls)
        self.dailyPrices = try container.decodeIfPresent([DailyPrice].self, forKey: .dailyPrices)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.cleaningFee = try container.decodeIfPresent(Int.self, forKey: .cleaningFee)
        self.propertyType = try container.decodeIfPresent(String.self, forKey: .propertyType)
        self.isReported = try container.decodeIfPresent(Bool.self, forKey: .isReported)
        self.bedRooms = try container.decodeIfPresent(Int.self, forKey: .bedRooms)
        self.bathRooms = try container.decodeIfPresent(Int.self, forKey: .bathRooms)
        self.host = try container.decodeIfPresent(Host.self, forKey: .host)
        self.whoCanStay = try container.decodeIfPresent(String.self, forKey: .whoCanStay)
        self.flexibleCheckIn = try container.decodeIfPresent(Bool.self, forKey: .flexibleCheckIn)
        self.flexibleCheckOut = try container.decodeIfPresent(Bool.self, forKey: .flexibleCheckOut)
        self.guests = try container.decodeIfPresent(Int.self, forKey: .guests)
        self.latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        self.longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
        self.beds = try container.decodeIfPresent(Int.self, forKey: .beds)
        self.checkInDate = try container.decodeDate(forKey: .checkInDate)
        self.checkOutDate = try container.decodeDate(forKey: .checkOutDate)
    }
    
}

// MARK: - DailyPrice
struct DailyPrice:  Codable, Identifiable, Equatable, Hashable{
    let day: String?
    let price: Int?
    let priceType, id: String?

    enum CodingKeys: String, CodingKey {
        case day, price, priceType
        case id = "_id"
    }
}

// MARK: - Host
struct Host:  Codable, Identifiable, Equatable, Hashable{
    let identityVerified: Bool?
    let id, firstName, lastName, email: String?

    enum CodingKeys: String, CodingKey {
        case identityVerified
        case id = "_id"
        case firstName
        case lastName
        case email
    }
}



//{
//            "_id": "64fa2e054da5fa03cd2b2852",
//            "title": "Daytona Breeze And Hawaiian Inn Daytona",
//            "description": "The two-bedroom townhome features a king bed in one bedroom and two twin beds in the other. It has 2 full bathrooms and a half bathroom, and an ample living room area. It is great for a family of 6, or even a group slightly bigger since the sofa converts into a bed. Cots can also be requested for an additional fee. This way, the whole family can stay under one roof and have the space to enjoy being together while having places to retreat to when they’ve had enough family time. The secure and beautifully-decorated 2-bedroom townhome at Encantada Resort provides many amenities that easily outshine those overpriced resorts on theme park property.",
//            "address": "Daytona Beach Shores, Florida, United States Share Save",
//            "imageUrls": [
//                "https://images.pexels.com/photos/1838554/pexels-photo-1838554.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750",
//                "https://images.pexels.com/photos/920383/pexels-photo-920383.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
//                "https://images.pexels.com/photos/6466236/pexels-photo-6466236.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
//                "https://images.pexels.com/photos/3316923/pexels-photo-3316923.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load"
//            ],
//            "dailyPrices": [
//                {
//                    "day": "monday",
//                    "price": 300,
//                    "priceType": "hourly",
//                    "_id": "64fa2e054da5fa03cd2b2853"
//                },
//                {
//                    "day": "tuesday",
//                    "price": 100,
//                    "priceType": "daily",
//                    "_id": "64fa2e054da5fa03cd2b2854"
//                },
//                {
//                    "day": "wednesday",
//                    "price": 200,
//                    "priceType": "hourly",
//                    "_id": "64fa2e054da5fa03cd2b2855"
//                }
//            ],
//            "type": "shared-room",
//            "cleaningFee": 200,
//            "propertyType": "flat",
//            "amenities": [],
//            "isReported": false,
//            "bedRooms": 3,
//            "bathRooms": 2,
//            "reviews": [],
//            "host": {
//                "identityVerified": false,
//                "_id": "64e7bb7f1556c58a17400dbd",
//                "first_name": "Brian",
//                "last_name": "Kiragu",
//                "email": "bkiragu27@gmail.com"
//            },
//            "whoCanStay": "male",
//            "cohosts": [],
//            "flexibleCheckIn": true,
//            "flexibleCheckOut": true,
//            "guests": 5,
//            "latitude": 23.684994,
//            "longitude": 90.356331,
//            "beds": 1,
//            "checkInDate": "2023-11-25T19:01:08.062Z",
//            "checkOutDate": "2023-12-30T19:01:08.062Z",
//            "createdAt": "2023-09-07T20:09:41.123Z",
//            "updatedAt": "2023-09-07T20:09:41.123Z",
//            "__v": 0
//        },

