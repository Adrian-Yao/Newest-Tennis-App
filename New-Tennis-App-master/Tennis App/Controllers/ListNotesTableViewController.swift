//
//  ListNotesTableViewController.swift
//  Tennis App
//
//  Created by adyao20 on 8/7/17.
//  Copyright © 2017 adyao20. All rights reserved.
//

import UIKit

class ListNotesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var hiddenLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var users = [User]() {
        didSet {
            
            users.sort { (one, two) -> Bool in
                return (Double(one.level!)!) >= (Double(two.level!)!)
            }
            tableView.reloadData()
        
        }
    }
    
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        UserService.timeline{ (users) in
            self.users = users
            if users.isEmpty {
                self.hiddenLabel.isHidden = false;

            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        UserService.usersExcludingCurrentUser { [unowned self] (user) in
//            self.user = user
        
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    

    //ACTIONS
    
    
    @IBAction func logOutButton(_ sender: Any) {
        AuthService.presentLogOut(viewController: self, completion: {(success) in
        
            let storyboard = UIStoryboard(name: "Login", bundle: .main)
            if let initialViewController = storyboard.instantiateInitialViewController() {
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
                
            }
        
        })
    
//        present( UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewControllerID") as UIViewController, animated: true, completion: nil)
        
//        [[self navigationController] popViewControllerAnimated:YES];

//        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"NameOfYourStoryBoard"
//            bundle:nil];
//        LoginViewController *add =
//            [storyboard instantiateViewControllerWithIdentifier:@"viewControllerIdentifier"];
//        
//        [self presentViewController:add
//            animated:YES
//            completion:nil];

    }
 
    
    @IBAction func backAction(_ sender: Any) {
    
        present( UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewControllerID") as UIViewController, animated: true, completion: nil)
        
        
    }
    // 1
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    // 2
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1
        let cell = tableView.dequeueReusableCell(withIdentifier: "listNotesTableViewCell", for: indexPath) as! ListNotesTableViewCell
        
        let row = indexPath.row
        let user = self.users[row]


        // 2
        cell.nameButton.text = user.displayName
        cell.phoneNumberButton.text = user.phoneNumber
        cell.levelButton.text = user.level
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "displayNote" {
                print("Table view cell tapped")
                
                // 1
                let indexPath = tableView.indexPathForSelectedRow!
                // 2
                let user = self.users[indexPath.row]
                // 3
                let displayInfoTableViewController = segue.destination as! DisplayInfoTableViewController
                // 4
                displayInfoTableViewController.user = user
                
            } else if identifier == "addNote" {
                print("+ button tapped")
            }
        }
    }
}

//    @IBAction func goBackToProfile(_ sender: Any) {
//        performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
//
//    }
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()


//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 10
//    }

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


