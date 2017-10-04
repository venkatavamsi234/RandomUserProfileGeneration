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
        
        guard let details = UserDefaults.standard.dictionary(forKey: "userInfo"), !details.isEmpty else {
            
            return
        }
        
        if let imageUrl = details["picture"] {
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
        if let userEmail = details["emailId"] {
            emailId.text = userEmail as? String
        }
        
        if let cell = details["mobileNumber"] {
            mobileNo.text = cell as? String
            
        }
        
        if let gender = details["gender"] {
            sex.text = gender as? String
        }
           }
}
