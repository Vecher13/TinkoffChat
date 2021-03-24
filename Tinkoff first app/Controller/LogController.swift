//
//  LogController.swift
//  Tinkoff first app
//
//  Created by Ash on 14.02.2021.
//

import Foundation
import UIKit

class LogController{
    
    //set true if you want to show logs or false to hide.
//    
    
    let isShowLog = true
    
    var oldState: String? = nil
    
    enum LifeCircle {
        case app
        case view
    }
    
    func showLog(function: String, for lifeCircle: LifeCircle){
       
        switch lifeCircle {
        case .app:
            if isShowLog == true{
                
                if oldState != nil {
                    print("Application moved from '\(states[oldState!]!)' to '\(states[function]!)': \(function)")
                } else {
                    print("Application moved to '\(states[function]!)' : \(function)")
                }
                
                oldState = function
            }
        case .view:
            if isShowLog == true{
                
                if oldState != nil {
                    print("View moved from '\(states[oldState!]!)' to '\(states[function]!)': \(function)")
                } else {
                    print("View moved to '\(states[function]!)' : \(function)")
                }
                
                oldState = function
            }
        
        }
        
        
    }
    let states = [
        "application(_:didFinishLaunchingWithOptions:)" : "almost ready to run",
        "applicationDidBecomeActive(_:)" : "app has become active",
        "applicationWillResignActive(_:)" : "app is about to become inactive",
        "applicationDidEnterBackground(_:)" : "app is now in the background",
        "applicationWillEnterForeground(_:)" : "app is about to enter the foreground",
        "applicationWillTerminate(_:)" : "app is about to terminate",
        "viewDidLoad()" : "view is loaded into memory",
        "viewWillAppear(_:)" : "view is about to be added to a view hierarchy",
        "viewWillLayoutSubviews()" : "view is about to layout its subviews",
        "viewDidLayoutSubviews()" : "view has just laid out its subviews",
        "viewWillDisappear(_:)" : "view is about to be removed from a view hierarchy",
        "viewDidDisappear(_:)" : "view was removed from a view hierarchy"
    ]
    
}

