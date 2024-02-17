////
//  PaymentData.swift
//  bug-free-goggles
//
//  Created by Mac on 24/05/23.
//

import Foundation

public struct PaymentData: Codable ,Equatable,Hashable{
    let amount: Int
    let currency: String
    let paymentMethod: String
    let paymentStatus: String
}
