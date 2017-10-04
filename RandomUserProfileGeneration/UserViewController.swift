//
//  UserViewController.swift
//  RandomUserProfileGeneration
//
//  Created by user on 03/10/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var userList:[String] = []
    var userDetails:[String:String] = [:]
    var arrayOfUsers:[[String: String]] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.topItem?.title = "Users"
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(abc(sender:)))
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }
    

    
    func abc(sender: UIBarButtonItem ) {
    
        let urlString = "https://randomuser.me/api/"
        
        guard let url =  URL(string: urlString) else {
            return
        }
        
        Alamofire.request(url).validate().responseJSON() { response in
            
            switch response.result {
            case .success:
                if  let value = response.result.value {
                    
                    let json = JSON(value)
                    
                    let results = json["results"][0]
                                        
                    guard let firstName = results["name"]["first"].string else {
                        return
                    }
                    
                    guard let secondName = results["name"]["last"].string else {
                        return
                    }
                    
                    guard let title = results["name"]["title"].string else {
                        return
                    }
                    
                    let fullName = "\(title + " " + firstName + " " +  secondName )"
                    self.userList.append(fullName)
                    
                    print(self.userList)
                    
                    UserDefaults.standard.set(self.userList, forKey: "usernames")
                        self.tableView.reloadData()
                    

                    
                    guard let picture = results["picture"]["medium"].string else {
                        return
                    }
                    
                    guard let emailId = results["email"].string else {
                        return
                    }
                    
                    guard let gender = results["gender"].string else {
                        return
                    }
                    
                    print(gender)
                    
                    guard let mobileNumber = results["cell"].string else {
                        
                        return
                    }
                    
                    print(mobileNumber)
                
                    self.userDetails =  ["emailId": emailId, "picture": picture, "gender": gender, "mobileNumber": mobileNumber]
                    
                    self.arrayOfUsers.append(self.userDetails)
                    print(self.arrayOfUsers)
                    UserDefaults.standard.set(self.userDetails, forKey: "userInfo")
                    
                }
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
    }
    
      func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = userList[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
        
    }
    
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexNo = indexPath.row
        
        guard let userInfoVc = storyboard?.instantiateViewController(withIdentifier: "UserInfoViewController") as? UserInfoViewController else {
            return
        }
        
        userInfoVc.myIndex = indexNo
        
        navigationController?.pushViewController(userInfoVc, animated: true)
    }
    

    
}
