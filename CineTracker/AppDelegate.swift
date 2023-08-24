//
//  AppDelegate.swift
//  CineTracker
//
//  Created by Jorge Andrade on 18/08/2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = .init()
        window?.rootViewController = TabbarController()
        window?.makeKeyAndVisible()

        HttpClient.shared.authorizationToken = CTWebserviceConfiguration().authenticationToken

        return true
    }
}

