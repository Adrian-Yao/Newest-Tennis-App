////
////  CreateUsernameViewController.swift
////  Tennis App
////
////  Created by adyao20 on 8/3/17.
////  Copyright © 2017 adyao20. All rights reserved.
////
//
//import UIKit
//import FirebaseAuth
//import FirebaseDatabase
//
//class CreateUsernameViewController: UIViewController {
//    
//    
//    @IBOutlet weak var usernameTextField: UITextField!
//    @IBOutlet weak var nextButton: UIButton!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        nextButton.layer.cornerRadius = 6
//    }
//    
//    @IBAction func nextButtonTapped(_ sender: Any) {
//        
//        guard let firUser = Auth.auth().currentUser,
//            let username = usernameTextField.text,
//            !username.isEmpty else { return }
//        //This problem seems to be that I need the outlets of display name, age, gender. .... in order to create this class. But it is in ProfileViewController. Perhaps I need to put everything in this file their?
//        UserService.create(firUser, displayName: "jim bob", age: Int, gender:Bool, level:Float, country:String, city:String, phoneNumber:String,info:String) { (user) in
//            guard let user = user
//                else {
//                    // handle error
//                    return
//            }
//            
//            User.setCurrent(user, writeToUserDefaults: true)
//            
//            let initialViewController = UIStoryboard.initialViewController(for: .main)
//            self.view.window?.rootViewController = initialViewController
//            self.view.window?.makeKeyAndVisible()
//        }
//        print("Created new user: \(username) is GREEN TEA MAMA")
//    }    }
//    
//
//
