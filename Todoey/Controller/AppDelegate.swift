//
//  AppDelegate.swift
//  Todoey
//
//  Created by Romeo Enso on 04/01/2018.
//  Copyright © 2018 Romeo Enso. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        print (Realm.Configuration.defaultConfiguration.fileURL as Any)
        return true
    }
}

