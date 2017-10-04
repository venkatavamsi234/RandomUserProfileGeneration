//
//  SettingsViewController.swift
//  RandomUserProfileGeneration
//
//  Created by user on 26/09/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SettingsViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            }
    
    override func viewWillAppear(_ animated: Bool) {
                
        self.navigationController?.navigationBar.topItem?.title = "Settings"
     
    }
    
    @IBAction func logOut(_ sender: Any) {
    
            let alert = UIAlertController(title: "SignOut", message: "Would you like to signOut", preferredStyle: UIAlertControllerStyle.alert)
            
        alert.addAction(UIAlertAction(title: "SignOut", style: UIAlertActionStyle.destructive, handler: userLogOut))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        func userLogOut(action: UIAlertAction)  {
            
            guard  let accessToken = UserDefaults.standard.string(forKey: "token") else {
                return
            }
            
            UserDefaults.standard.removeObject(forKey: "token")
            
            guard let apiToContact = try? "https://accounts.google.com/o/oauth2/revoke?token=\(accessToken)".asURL() else {
                return
            }
            
            Alamofire.request(apiToContact, method: .get, parameters: nil, encoding: URLEncoding.default, headers: ["Content-Type": "application/x-www-form-urlencoded"]).responseJSON() { response in
                
                switch response.result {
                    
                case .success:
                    if let value = response.result.value {
                        
                        let json = JSON(value)
                        print(json)
                        print("The Token has been successfully revoked")
                        
                    }
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            guard  let  lvc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
                
                return
                
            }
            
            navigationController?.pushViewController(lvc, animated: false)
            
        }
        

        
    }
    

