////
//  Colors.swift
//  bug-free-goggles
//
//  Created by Mac on 01/05/23.
//

import SwiftUI
import UIKit

extension Color {
    /// #0057FF
    static let appPrimary = Color("LightBlue")
    /// #787880
//    static let primaryGray = Color("PrimaryGray")
//    /// #3C3C43 - 60%
//    static let secondaryGray = Color("SecondaryGray")
//    /// #EBEBF5 - 60%
//    static let lightGray = Color("LightGray")
//    /// #919BA7
//    static let lightGrayText = Color("LightGrayText")
//    /// #F2F2F7
//    static let darkWhite = Color("DarkWhite")
//    /// White & Black
//    static let background = Color("Background")
//    /// #F5F8FE
//    static let darkWhite1 = Color("DarkWhite1")
//    /// #F7F7F8
//    static let darkWhite2 = Color("DarkWhite2")
//    /// #272D37
//    static let gray700 = Color("Gray700")
//    /// #574EFA
//    static let darkIndigo = Color("darkIndigo")
//    /// #5F6D7E
//    static let darkGray = Color("DarkGray")
//    /// #E5E7EB
//    static let midGray = Color("MidGray")
//    /// #111827
//    static let grayBackground = Color("GrayBackground")
//    /// #DAE0E6
//    static let neutral700 = Color("Neutral700")
//    /// #ECEBFF
//    static let lightIndigo = Color("LightIndigo")
//    /// #2D8A39
//    static let darkGreen = Color("DarkGreen")
//    /// #F0FAF0
//    static let lightGreen = Color("LightGreen")
//    /// #FD5E49
//    static let lightRed = Color("LightRed")
    /// #FD5E49
    static let appRed = Color("LightRed")
    /// #FD5E49
    static let appBlue = Color("LightIndigo")
    /// Any - #F2F2F7     Dark: #F1F1F7
//    static let secondaryLightGray = Color("SecondaryLightGray")
//    /// #49556D
//    static let stormyBlue = Color("StormyBlue")
    
    func toUIColor() -> UIColor{
        guard let cgColor = cgColor else {
            return .black
        }
        return UIColor(cgColor: cgColor)
    }
    
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
}

