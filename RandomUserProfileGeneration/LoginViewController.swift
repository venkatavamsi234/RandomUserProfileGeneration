//
//  LoginViewController.swift
//  RandomUserProfileGeneration
//
//  Created by user on 26/09/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController, SFSafariViewControllerDelegate {
    
       var svc:SFSafariViewController?
    
    var urlString:String = "https://accounts.google.com/o/oauth2/v2/auth?response_type=code&redirect_uri=com.fullCreative.RandomUserProfileGeneration:/oauth2redirect&client_id=571036347521-b401a5oiaala7q1b3mb29rncg6034tp4.apps.googleusercontent.com&scope=https://www.googleapis.com/auth/userinfo.profile"

 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.accessTokenMethod), name: NSNotification.Name(rawValue: "My work is done"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
        @IBAction func signInWithGoogle(_ sender: UIButton) {
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        svc = SFSafariViewController(url: url)
        
        guard let safariViewController = svc else {
            return
        }
        
        safariViewController.delegate = self
        self.present(safariViewController, animated: false, completion: nil)
        
    }
    
    func accessTokenMethod() {
        svc?.dismiss(animated: false, completion: nil)
        
        if let  tbc = storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
            
        {
            
            navigationController?.pushViewController(tbc, animated: false)
        }
        
        
    }
    
}
