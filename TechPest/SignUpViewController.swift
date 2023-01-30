//
//  SignUpViewController.swift
//  TechPest
//
//  Created by Isidro  Perez on 12/2/22.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var countyField: UITextField!
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user["name"] = nameField.text
        user["county"] = countyField.text
        user.username = usernameField.text
        user.password = passwordField.text

        user.signUpInBackground{ (success, error) in
            if success{
                self.performSegue(withIdentifier: "signUptoHomeSegue", sender: nil)
            } else {
                let alert = UIAlertController(
                            title: "Sign Up Error",
                            message: "Sorry! We could not sign you up! Please check your details and try again.",
                            preferredStyle: UIAlertController.Style.alert)

                let OKAction = UIAlertAction(title: "Okay", style: .default) { (action) in
                            // do something when user press OK button, like deleting text in both fields or do nothing
                        }

                        alert.addAction(OKAction)

                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

// @IBOutlet weak var usernameField: UITextField!
//    @IBOutlet weak var passwordField: UITextField!
//    @IBOutlet weak var numberField: UITextField!
//
//    @IBAction func onSaveButton(_ sender: Any) {
//        //var user = PFUser()
////        user.username = usernameField.text
////        user.password = passwordField.text
////        user["opnumber"] = numberField.text!
//
////        user.signUpInBackground{ (success, error) in
////            if success {
////                self.dismiss(animated: true, completion: nil)
//                //print("saved!")
////            } else {
////                print("Error: \(String(describing: error?.localizedDescription))")
////            }
////
////        }
//    }
//
//    @IBAction func onBackButton(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
