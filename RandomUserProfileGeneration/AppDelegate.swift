//
//  AppDelegate.swift
//  RandomUserProfileGeneration
//
//  Created by user on 26/09/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
        var window: UIWindow?
    let notificationKey = Notification.Name("My work is done")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
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
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        print(url)
        guard let code = url.query else {
            return false
        }
        
        let authCode = code.components(separatedBy: "=")
        
        getAccessToken(str:authCode[1])
            return true
    }
    
    func getAccessToken(str:String) {
        
        let url = try! "https://www.googleapis.com/oauth2/v4/token".asURL()
        
        let params: [String: Any] = ["code": str,
                                     "client_id": "571036347521-b401a5oiaala7q1b3mb29rncg6034tp4.apps.googleusercontent.com",
                                     "redirect_uri": "com.fullCreative.RandomUserProfileGeneration:/oauth2redirect",
                                     "grant_type": "authorization_code"
        ]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: ["Content-Type": "application/x-www-form-urlencoded"]).responseData { (
            response) in
            switch response.result {
                
            case .success:
                
                if let value = response.result.value {
                    
                    let json = JSON(value)
                    print(json)
                    let tokenToAccess = json["access_token"]
                    if let accessToken = tokenToAccess.string{
                        print(accessToken)
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(accessToken, forKey: "token")
                        UserDefaults.standard.synchronize()
                    }
                    
                    NotificationCenter.default.post(name: self.notificationKey, object: self)
                    
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    

    }



