//
//  AppDelegate.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 14/05/2023.
//

import UIKit
import GoogleMaps

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GMSServices.provideAPIKey("AIzaSyAlv7r8xSCloiUSrrg5Kto8294355j_KNE")
        return true
    }
}
