//
//  HomeViewController.swift
//  RandomUserProfileGeneration
//
//  Created by user on 26/09/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeMessage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Home"
        
        guard let accessToken = UserDefaults.standard.string(forKey: "token") else {
            return
        }
        
        guard let apiToContact = try? "https://www.googleapis.com/oauth2/v2/userinfo?acessToken=\(accessToken)".asURL() else {
            return
        }
        
        Alamofire.request(apiToContact, method: .get, parameters: nil, encoding: URLEncoding.default, headers: ["Authorization": "Bearer \(accessToken)"]).responseJSON() { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    if  let userName = json["name"].string {
                        self.welcomeMessage.text = "Hi, \(userName) welcome to RandomUserGeneration Application"
                    }
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }
}
