//
//  AppDelegate.swift
//  UpButton
//
//  Created by Павел Попов on 24/05/2019.
//  Copyright © 2019 Yopi Studio. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //swiftStep 1: Add the following code right under AppDelegate class declaration
    let displayStatusChanged: CFNotificationCallback = { center, observer, name, object, info in
        let str = name!.rawValue as CFString
        if (str == "com.apple.springboard.lockcomplete" as CFString) {
            let isDisplayStatusLocked = UserDefaults.standard
            isDisplayStatusLocked.set(true, forKey: "isDisplayStatusLocked")
            isDisplayStatusLocked.synchronize()
        }
    }
    //--------------------------
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
  
    //swiftStep 2: add the following code

        let isDisplayStatusLocked = UserDefaults.standard
        isDisplayStatusLocked.set(false, forKey: "isDisplayStatusLocked")
        isDisplayStatusLocked.synchronize()
        
        // Darwin Notification
        let cfstr = "com.apple.springboard.lockcomplete" as CFString
        let notificationCenter = CFNotificationCenterGetDarwinNotifyCenter()
        let function = displayStatusChanged
        CFNotificationCenterAddObserver(notificationCenter,
                                        nil,
                                        function,
                                        cfstr,
                                        nil,
                                        .deliverImmediately)
    //-----------------------------------
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
    //swiftStep 3: add the following code
    
        let isDisplayStatusLocked = UserDefaults.standard
        if let lock = isDisplayStatusLocked.value(forKey: "isDisplayStatusLocked"){
            // user locked screen
            if(lock as! Bool){
                
                // do anything you want here
                let exitStr = "Lock Button Pressed!"
                let exitStatus = UserDefaults.standard
                exitStatus.set(exitStr, forKey: "exitStatus")
                exitStatus.synchronize()
                print(exitStr)
                
            }
            else{
                
                // do anything you want here
                let exitStr = "Home Button Pressed!"
                let exitStatus = UserDefaults.standard
                exitStatus.set(exitStr, forKey: "exitStatus")
                exitStatus.synchronize()
                print(exitStr)
            }
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateExitStatus"), object: nil)
        //-----------------------------------
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        //swiftStep 4: add the following code:
        print("Back to foreground.")
        
        //restore lock screen setting
        
        let isDisplayStatusLocked = UserDefaults.standard
        isDisplayStatusLocked.set(false, forKey: "isDisplayStatusLocked")
        isDisplayStatusLocked.synchronize()
        //-----------------------------------
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
