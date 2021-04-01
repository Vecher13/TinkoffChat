//
//  AppDelegate.swift
//  Tinkoff first app
//
//  Created by Ash on 13.02.2021.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let theme12 = DarkThemeOld()
    private let theme13 = ThemesManager()
    var coreDataStack = CoreDataStack()
    var window: UIWindow?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
     
        ThemesManager.shared.setTheme(theme: NightTheme())
        ThemesManager.shared.theme?.applayAppearance(for: application)
        
//        theme12.apply(for: application)
        return true
    }
    
    var logVC = LogController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        logVC.showLog(function: #function, for: .app)
       
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
//        print(#function)
        logVC.showLog(function: #function, for: .app)
        
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
//        print(#function)
        logVC.showLog(function: #function, for: .app)
        
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
//        print(#function)
        logVC.showLog(function: #function, for: .app)
        
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
//        print(#function)
        logVC.showLog(function: #function, for: .app)
       
    }

    func applicationWillTerminate(_ application: UIApplication) {
//        print(#function)
        logVC.showLog(function: #function, for: .app)
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}
