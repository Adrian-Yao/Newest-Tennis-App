//
//  PictureViewController.swift
//  Tennis Twins
//
//  Created by adyao20 on 29/6/2018.
//  Copyright © 2018 adyao20. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController {

    var image:UIImage?
    
    @IBOutlet weak var bigProfilePic: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bigProfilePic.image = self.image
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
