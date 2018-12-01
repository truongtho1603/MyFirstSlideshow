//
//  AppDelegate.swift
//  MyFirstSlideshow
//
//  Created by Charles Vu on 17/05/2017.
//  Copyright © 2017 Yoti. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = CarouselViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}
