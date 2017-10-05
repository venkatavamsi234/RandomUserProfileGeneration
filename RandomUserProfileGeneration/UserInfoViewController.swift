//
//  UserInfoViewController.swift
//  RandomUserProfileGeneration
//
//  Created by user on 03/10/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var emailId: UILabel!
    
    @IBOutlet weak var mobileNo: UILabel!
    
    @IBOutlet weak var sex: UILabel!
    
    var myIndex:Int = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        
        guard let details = UserDefaults.standard.array(forKey: "userInfo"), !details.isEmpty else {
            
            return
        }
        
        guard let userDetails = details[myIndex] as? NSDictionary else {
            return
        }
      
           if let imageUrl = userDetails["picture"] {
            if let url =  URL(string: imageUrl as! String) {
            let data = try? Data(contentsOf: url)
                
                if let imageData = data {
                    
                    let mediumImage = UIImage(data: imageData)
                    
                    self.imageView.image = mediumImage
                    
                    self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2
                    
                    self.imageView.clipsToBounds = true
                    
                    self.imageView.layer.borderColor = UIColor.white.cgColor
                    
                    self.imageView.layer.borderWidth = 3
                    
                    

                    
                }
            }
        }
        
        if let userEmail = userDetails["emailId"] {
            emailId.text = userEmail as? String
        }
        
        if let cell = userDetails["mobileNumber"] {
            mobileNo.text = cell as? String
            
        }
        
        if let gender = userDetails["gender"] {
            sex.text = gender as? String
        }
           }
}
