////
//  RoommateData.swift
//  bug-free-goggles
//
//  Created by Mac on 16/05/23.
//

import Foundation

public struct RoommateData: Codable, Identifiable ,Equatable,Hashable{
    public let id: String
    let firstName: String
    let lastName: String
    let email: String
    let gender: String?
    let images: [ImageData]?
    let bio: String
    let occupation: String
    let interests: String
    let language: String?
    let memberSince: Date
    let user: String
    let room: String
    let city: String
    let country: String
    
    var roomData: RoomData?
    
    var name: String {
        "\(firstName) \(lastName)"
    }
    
    var address: String {
        "\(city), \(country)"
    }
    
    var memberSinceText: String {
        "MEMBER SINCE \(memberSince.toString(format: .MMMddyyyy).uppercased())"
    }
    
    var imageList: [String]? {
        images?.map { $0.url }
    }
    
    init(id: String, firstName: String, lastName: String, email: String, gender: String?, images: [ImageData]?, bio: String, occupation: String, interests: String, language: String?, memberSince: Date, user: String, room: String, city: String, country: String, roomData: RoomData? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.gender = gender
        self.images = images
        self.bio = bio
        self.occupation = occupation
        self.interests = interests
        self.language = language
        self.memberSince = memberSince
        self.user = user
        self.room = room
        self.city = city
        self.country = country
        self.roomData = roomData
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.email = try container.decode(String.self, forKey: .email)
        self.gender = try container.decodeIfPresent(String.self, forKey: .gender)
        self.images = try container.decodeIfPresent([ImageData].self, forKey: .images)
        self.bio = try container.decode(String.self, forKey: .bio)
        self.occupation = try container.decode(String.self, forKey: .occupation)
        self.interests = try container.decode(String.self, forKey: .interests)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        self.memberSince = try container.decodeDate(forKey: .memberSince)
        self.user = try container.decode(String.self, forKey: .user)
        self.room = try container.decode(String.self, forKey: .room)
        self.city = try container.decode(String.self, forKey: .city)
        self.country = try container.decode(String.self, forKey: .country)
    }
    
    func roomMateDetails() -> [KeyValueModel] {
        var list: [KeyValueModel] = []
        if let gender = gender {
            list.append(KeyValueModel(key: "Gender", value: gender))
        }
        list.append(KeyValueModel(key: "Occupation", value: occupation))
        list.append(KeyValueModel(key: "Interests", value: interests))
        if let language = language {
            list.append(KeyValueModel(key: "Languages", value: language))
        }
        return list
    }
}


extension RoommateData{
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case gender
        case images
        case bio
        case occupation
        case interests
        case language
        case memberSince
        case user
        case room
        case city
        case country
    }
    
}
