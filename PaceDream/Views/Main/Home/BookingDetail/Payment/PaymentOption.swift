////
//  PaymentOption.swift
//  bug-free-goggles
//
//  Created by Mac on 15/05/23.
//

import Foundation

struct PaymentOption: Identifiable {
    let id: String = UUID().uuidString
    let image: String
    let title: String
}

let paymentMothods: [PaymentOption] = [
    PaymentOption(image: "googleIcon", title: "Google Pay"),
    PaymentOption(image: "paypalIcon", title: "Pay Pal"),
    PaymentOption(image: "appleIcon", title: "Apple Pay")
]

let cards: [PaymentOption] = [
    PaymentOption(image: "masterCard", title: "**** **** **** 1728"),
    PaymentOption(image: "westerUnionCard", title: "**** **** **** 3423"),
    PaymentOption(image: "visaCard", title: "**** **** **** 2930"),
]
