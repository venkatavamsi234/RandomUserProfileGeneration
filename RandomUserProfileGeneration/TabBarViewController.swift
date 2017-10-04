//
//  TabBarViewController.swift
//  RandomUserProfileGeneration
//
//  Created by user on 26/09/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
}







