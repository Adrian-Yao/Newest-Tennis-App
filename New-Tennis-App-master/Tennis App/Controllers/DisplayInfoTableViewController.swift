//
//  DisplayNoteTableViewController.swift
//  Tennis App
//
//  Created by adyao20 on 8/14/17.
//  Copyright © 2017 adyao20. All rights reserved.
//

import UIKit

class DisplayInfoTableViewController: UIViewController {
    var user: User?
    var users: [User]?
    var avatarUrl: String = ""

    
    @IBOutlet weak var displayName2: UILabel!
    @IBOutlet weak var displayAge: UILabel!
    @IBOutlet weak var displayGender: UILabel!
    @IBOutlet weak var displayInfo: UILabel!
    @IBOutlet weak var displayLevel: UILabel!
    @IBOutlet weak var displayCountry: UILabel!
    @IBOutlet weak var displayPhoneNumber: UILabel!
    @IBOutlet weak var profilePicImage: UIImageView!
    
    
    
    
    @IBAction func profilePicTapped(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "expandPictureSegueID", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "expandPictureSegueID" {
            let vc = segue.destination as! PictureViewController
            vc.image = self.profilePicImage.image
        }
    }
    
    @IBAction func phoneNumberTapped(_ sender: UITapGestureRecognizer) {
        
        let alert = UIAlertController(title: "Get in contact with " + displayName2.text!, message: "", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let takePicture = UIAlertAction(title: "Call", style: .default) { (action) in
            let phoneNumber = self.displayPhoneNumber.text
            let actionStr = "tel://" + phoneNumber!
//            let actionStr = "sms:" + phoneNumber!
            let webView = UIWebView()
            webView.loadRequest(URLRequest(url: URL(string: actionStr)!))
            self.view.addSubview(webView)
        }
        let choosePicture = UIAlertAction(title: "Message", style: UIAlertActionStyle.default) { (action) in
            let phoneNumber = self.displayPhoneNumber.text
            //        let actionStr = "tel://" + phoneNumber!
            let actionStr = "sms:" + phoneNumber!
            let webView = UIWebView()
            webView.loadRequest(URLRequest(url: URL(string: actionStr)!))
            self.view.addSubview(webView)
        }
        alert.addAction(takePicture)
        alert.addAction(choosePicture)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion:nil)
        
        
    }
    
    
    @IBAction func NTRPLink(_ sender: Any) {
        openUrl(urlStr: "https://blog.universaltennis.com/2017/06/29/the-universal-tennis-16-level-chart/")
    }
    
    func openUrl(urlStr:String!) {
        
        if let url = NSURL(string:urlStr) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    override func viewDidLoad() {
         super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            // if note exists, update title and content
//            let note = self.note ?? CoreDataHelper.newNote()
//            note.title = noteTitleTextField.text ?? ""
//            note.content = noteContentTextView.text ?? ""
//            note.modificationTime = Date() as NSDate
//        }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 1
        if let user = user {
            // 2
            displayName2.text = user.displayName
            displayAge.text = user.age
            displayGender.text = user.gender
            displayInfo.text = user.info
            displayLevel.text = user.level
            displayCountry.text = user.country
            displayPhoneNumber.text = user.phoneNumber
            // Downloading other user's pictures
            guard let img =  user.image else {
                return
            }
            
            if img == "" {
                return
            }
            self.avatarUrl = img
            
            DispatchQueue.global(qos: .default).async(execute: {
                do {
                    let data = try Data(contentsOf:URL(string:self.avatarUrl)!)
                    DispatchQueue.main.async {
                        self.profilePicImage.image = UIImage(data: data)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            })
            
        } else {
            // 3
            displayName2.text = ""
            displayAge.text = ""
            displayGender.text = ""
            displayInfo.text = ""
            displayLevel.text = ""
            displayCountry.text = ""
            displayPhoneNumber.text = ""
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
