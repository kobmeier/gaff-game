//
//  AppDelegate.swift
//  GreatAmericanFamilyFunGame
//
//  Created by Kerry S Dobmeier on 11/26/16.
//  Copyright © 2016 Kerry. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let game = Game()
        let navController = window?.rootViewController as! UINavigationController
        let settingsVC = navController.topViewController as! SettingsViewController
        settingsVC.game = game
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}

