//
//  NavigationViewController.swift
//  RandomUserProfileGeneration
//
//  Created by user on 26/09/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let token = UserDefaults.standard.string(forKey: "token")
        
        guard let accessToken = token, !accessToken.isEmpty else {
            
            print("User information not available, please go into loginpage.")
            
            return
        }
        
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if let tbvc = mainStoryboard.instantiateViewController(withIdentifier:"TabBarViewController") as? TabBarViewController {
                let nav = UINavigationController(rootViewController: tbvc)
                appdelegate.window?.rootViewController = nav
                
            }
            
        }

        
    }
    
    

   
}
