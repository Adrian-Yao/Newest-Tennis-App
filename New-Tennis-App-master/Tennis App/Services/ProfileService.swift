////
////  PostService.swift
////  Tennis App
////
////  Created by adyao20 on 8/10/17.
////  Copyright © 2017 adyao20. All rights reserved.
//
//
//import UIKit
//import FirebaseStorage
//import FirebaseDatabase
//
//
//struct ProfileService {
////    static func create(for image: UIImage) {
////        let imageRef = StorageReference.newPostImageReference()
////        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
////            guard let downloadURL = downloadURL else {
////                return
////            }
////            
////            let urlString = downloadURL.absoluteString
////            let aspectHeight = image.aspectHeight
////            create(forURLString: urlString, aspectHeight: aspectHeight)
////        }
////    }
//    //
//    //    private static func create(forURLString urlString: String, aspectHeight: CGFloat) {
//    //        // create new post in database
//    //        // 1
//    //        let currentUser = User.current
//    //        // 2
//    //        let post = Post(imageURL: urlString, imageHeight: aspectHeight)
//    //        // 3
//    //        let dict = post.dictValue
//    //
//    //        // 4
//    //        let postRef = Database.database().reference().child("posts").child(currentUser.uid).childByAutoId()
//    //        //5
//    //        postRef.updateChildValues(dict)
//    //    }
//   
//    
//    private static func create(age age1: Int, gender gender1: Bool, level level1: Float, country country1: String, city city1: String, phoneNumber phoneNumber1: String, info info1: String?) {
//        
//        let currentUser = User.current
//        let profile = Profile(age:age1, gender: gender1, level: level1, country: country1, city: city1, phoneNumber: phoneNumber1, info: info1)
//        
//        // 1
//        let rootRef = Database.database().reference()
//        let newProfileRef = rootRef.child("profile").child(currentUser.uid).childByAutoId()
//        let newProfileKey = newProfileRef.key
//        
////        // 2
////        UserService.followers(for: currentUser) { (followerUIDs) in
////            // 3
////            let timelinePostDict = ["poster_uid" : currentUser.uid]
////            
////            // 4
////            var updatedData: [String : Any] = ["timeline/\(currentUser.uid)/\(newPostKey)" : timelinePostDict]
////            
////            // 5
////            for uid in followerUIDs {
////                updatedData["timeline/\(uid)/\(newPostKey)"] = timelinePostDict
////            }
////            
////            // 6
////            let postDict = post.dictValue
////            updatedData["posts/\(currentUser.uid)/\(newPostKey)"] = postDict
////            
////            // 7
////            rootRef.updateChildValues(updatedData)
////        }
//    }
//    static func show(forKey postKey: String, posterUID: String, completion: @escaping (Profile?) -> Void) {
//        let ref = Database.database().reference().child("profile").child(posterUID).child(postKey)
//        
//        ref.observeSingleEvent(of: .value, with: { (snapshot) in
//            guard let profile = Profile(snapshot: snapshot) else {
//                return completion(nil)
//            }
//            
////            LikeService.isPostLiked(post) { (isLiked) in
////                post.isLiked = isLiked
////                completion(post)
////            }
//        })
//    }
//}
