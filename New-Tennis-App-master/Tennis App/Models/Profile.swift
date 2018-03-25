//
////
////  File.swift
////  Tennis App
////
////  Created by adyao20 on 8/10/17.
////  Copyright © 2017 adyao20. All rights reserved.
////
//
//import UIKit
//import FirebaseDatabase.FIRDataSnapshot
//
////I COMMENTED OUT SOMETHING AT THE BOTTOM
//
//class Profile {
// 
//    var age: Int
//    var gender: Bool
//    var level: Float
//    var country: String
//    var city: String
//    var phoneNumber: String
//    var info: String
//    var key: String?
//    
//    let poster:User
//    var dictValue: [String : Any] {
//        let userDict = ["uid" : poster.uid,
//                        "username" : poster.username]
//        
//        return ["age" : age,
//                "gender" : gender,
//                "level" : level,
//                "country" : country,
//                "city" : city,
//                "phoneNumber" : phoneNumber,
//                "info" : info,
//                "poster":userDict]
//    }
//   
//    
//    
//    init(age: Int?, gender: Bool?, level: Float, country: String?, city: String?, phoneNumber: String?, info: String?) {
//        self.age = age!
//        self.gender = gender!
//        self.level = level
//        self.country = country!
//        self.city = city!
//        self.phoneNumber = phoneNumber!
//        self.info = info!
//        
//        self.poster = User.current
//    }
//    
//    
//    init?(snapshot: DataSnapshot) {
//        guard let dict = snapshot.value as? [String : Any],
//            let age = dict["age"] as? Int,
//            let gender = dict["gender"] as? Bool,
//            let level = dict["level"] as? Float,
//            let country = dict["country"] as? String,
//            let city = dict["city"] as? String,
//            let phoneNumber = dict["phoneNumber"] as? String,
//            let info = dict["info"] as? String,
//        
//            let userDict = dict["poster"] as? [String : Any],
//            let uid = userDict["uid"] as? String,
//            let username = userDict["username"] as? String
//        
//            else { return nil }
//
//        
//        self.key = snapshot.key
//        self.age = age
//        self.gender = gender
//        self.level = level
//        self.country = country
//        self.city = city
//        self.phoneNumber = phoneNumber
//        self.info = info
//        
//      //  self.poster = User(uid: uid, username: username)
//
//    }
//    
//    
//    
//}
