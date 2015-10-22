//
//  AppDelegate.swift
//  EarthquakeCounter
//
//  Created by Rachel Bobbins on 10/17/15.
//  Copyright © 2015 Rachel Bobbins. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow()

        let welcomeViewController = WelcomeViewController()
        let navController = UINavigationController(rootViewController: welcomeViewController)
        navController.navigationBar.translucent = false
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
}

