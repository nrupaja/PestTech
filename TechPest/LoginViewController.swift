//
//  LoginViewController.swift
//  TechPest
//
//  Created by Isidro  Perez on 12/2/22.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogIn(_ sender: Any) {
        
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) {
            (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginToHomeSegue", sender: nil)
            } else {
                let alert = UIAlertController(
                            title: "Invalid Login",
                            message: "Please Enter the Correct Username/Password",
                            preferredStyle: UIAlertController.Style.alert)

                let OKAction = UIAlertAction(title: "Okay", style: .default) { (action) in
                            // do something when user press OK button, like deleting text in both fields or do nothing
                        }

                        alert.addAction(OKAction)

                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
