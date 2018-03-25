//
//  ViewController.swift
//  Tennis App
//
//  Created by adyao20 on 8/2/17.
//  Copyright © 2017 adyao20. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import GooglePlaces

class ProfileViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate {
    
    var age: String?
    var gender: String?
    var level: String?
    var country: String?
    var phoneNumber: String?
    var info: String?
    var value: String?
    
    var isNewUser: Bool = false
    

    
    //PICKER VIEWS
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return 59
        } else if pickerView.tag == 1 {
            return 13
        } else {
            return 0
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 0 {
            return String(row + 12) //age
        } else if pickerView.tag == 1 {
            return String(Double((row) + 2) / 2 ) //level
        } else {
            return ""
        }
    }
    
    
    
        //  MARK - Instance Methods
    
    
    
    
    //OVERRIDE FUNCTIONS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        agePicker.delegate = self
        agePicker.dataSource = self
        levelPicker.delegate = self
        levelPicker.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.hideKeyboardWhenTappedAround()
        
        
        if isNewUser == false {
            let user = User.current
            nameTextField.text = user.displayName
            agePicker.selectRow(Int((user.age!))! - 12, inComponent: 0, animated: false)
            if user.gender == "Male" { genderSegmentControl.selectedSegmentIndex = 0 }
            else { genderSegmentControl.selectedSegmentIndex = 1 }
            levelPicker.selectRow(Int((2.0 * Double((user.level!))!) - 2.0), inComponent: 0, animated: false)
            countryTextField.text = user.country
            phoneNumberTextField.text = user.phoneNumber
            infoTextView.text = user.info
            
        }
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileViewController.keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileViewController.keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        infoTextView.delegate = self
    
        //    countrySearchTextField.filterStrings(["United States", "England", "China"])

    }
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    func keyboardShowing(sender: NSNotification) {
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            infoTextView.resignFirstResponder()
            return false
        }
        return true
    }
//    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
//      
//    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(infoTextView.text == "Home Courts, Best Times") {
            infoTextView.text = ""
        }
        infoTextView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if(infoTextView.text == "") {
            infoTextView.text = "Home Courts, Best Times"
        }
        infoTextView.resignFirstResponder()
    }
    
    //OUTLET
    @IBOutlet weak var profilePicButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var agePicker: UIPickerView!
    @IBOutlet weak var genderSegmentControl: UISegmentedControl!
    @IBOutlet weak var levelPicker: UIPickerView!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var matchButton: UIButton!
    
  
    
    
    
    //ACTION
    
    @IBAction func profileLink(_ sender: Any) {
        openUrl(urlStr: "http://assets.usta.com/assets/639/15/National%20tennis%20Rating%20Program.pdf")
    }
    
    func openUrl(urlStr:String!) {
        
        if let url = NSURL(string:urlStr) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }

    
    
    
    @IBAction func profileButtonTapped(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Feature Coming Soon.", message: "Due to appear in next update", preferredStyle: .alert)
        
        //                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
        //                    // ...
        //                }
        //                alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            // ...
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true) {
            // ...
        }
        return
        
    }
    
    

    @IBAction func countryTextFieldTapped(_ sender: Any) {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        let filter = GMSAutocompleteFilter()
        filter.type = .city
        autocompleteController.autocompleteFilter = filter
        
        present(autocompleteController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func matchButtonTapped(_ sender: Any) {
        
        let ageValue = String(agePicker.selectedRow(inComponent: 0) + 12)
        //        var genderValue = Bool(genderSegmentControl.value)
        let genderValue: String? = genderSegmentControl.titleForSegment(at: genderSegmentControl.selectedSegmentIndex)!
        let levelValue = String((levelPicker.selectedRow(inComponent: 0) + 2)/2)
        
        guard let firUser = Auth.auth().currentUser,
            let displayName = nameTextField.text,
            !displayName.isEmpty,
            let age = String(ageValue),
            !(ageValue.isEmpty),
            let gender = genderValue,
            !(genderValue?.isEmpty)!,
            let level = String(levelValue),
            !(levelValue.isEmpty),
            let country = countryTextField.text,
            !country.isEmpty,
            let phoneNumber = phoneNumberTextField.text,
            !phoneNumber.isEmpty,
            let info = infoTextView.text,
            !info.isEmpty
            
            else {
                let alertController = UIAlertController(title: "Fill out all boxes", message: "for improved accuracy of your buddy.", preferredStyle: .alert)
                
                //                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
                //                    // ...
                //                }
                //                alertController.addAction(cancelAction)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { action in
                    // ...
                }
                alertController.addAction(OKAction)
                
                self.present(alertController, animated: true) {
                    // ...
                }
                return
        }
        
        //        if (nameTextField.text == "" || nameTextField.text == "" || countryTextField.text == "" || cityTextField.text == "" || phoneNumberTextField.text == "" || infoTextView.text == "")  {
        //
        //            errorLabel.text = "You need to fill out all fields"
        //            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        //                self.errorLabel.text = ""
        //            }
        //        }
        //
        UserService.create(firUser, displayName: displayName, age: age, gender:gender, level:level, country:country, phoneNumber:phoneNumber,info:info) { (retrievedUser) in
            guard let user = retrievedUser
                else {
                    // handle error
                    return
            }
            
            User.setCurrent(user, writeToUserDefaults: true)
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let initialViewController = storyboard.instantiateInitialViewController()
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }
        
        
        
        
    }
    
    
    
    
}

//EXTENSIONS

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ProfileViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.countryTextField.text = place.formattedAddress
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
