//
//  AddLogViewController.swift
//  TechPest
//
//  Created by Isidro  Perez on 12/2/22.
//

import UIKit
import Parse

class AddLogViewController: UIViewController {
    
    
    @IBOutlet weak var locationField: UITextField!
    
    @IBOutlet weak var monthField: UITextField!
    @IBOutlet weak var dayField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    
    @IBOutlet weak var appTypeField: UITextField!
    
    @IBOutlet weak var commodityField: UITextField!
    
    @IBOutlet weak var areaField: UITextField!
    
    @IBOutlet weak var productNameField: UITextField!
    
    @IBOutlet weak var epaField: UITextField!
    
    @IBOutlet weak var usedProductField: UITextField!
    
    @IBOutlet weak var rateField: UITextField!
    
    @IBOutlet weak var mixField: UITextField!
    
    @IBOutlet weak var requiredfieldimage1: UIImageView!
    
    
    @IBOutlet weak var requiredfieldimage2: UIImageView!
    
    @IBOutlet weak var requiredfieldimage3: UIImageView!

//    var month:Int = 0
//    var day:Int = 0
//    var year:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.requiredfieldimage1.isHidden = true
        self.requiredfieldimage2.isHidden = true
        self.requiredfieldimage3.isHidden = true
        
//        dayField.text = String(day)
//        monthField.text = String(month)
//        yearField.text = String(year)
        // Do any additional setup after loading the view.
    }
        
    @IBAction func onSaveButton(_ sender: Any) {
        var log = PFObject(className: "Pesticide")
        
        log["location"] = locationField.text!
        log["author"] = PFUser.current()!
        //user["author"] = "Test"
        var saveString = monthField.text! + " " + dayField.text! + " " + yearField.text!
        log["date"] = saveString
        log["application"] = appTypeField.text!
        log["commondity"] = commodityField.text!
        log["treated"] = areaField.text!
        log["pesticide"] = productNameField.text!
        log["epanumber"] = epaField.text!
        log["measureunit"] = usedProductField.text!
        log["rateunit"] = rateField.text!
        log["dilution"] = mixField.text!
        log["weather"] = "Sunny"

        let productname = productNameField.text
        let appType = appTypeField.text
        let date = monthField.text! + dayField.text! + yearField.text!
        
        if(date.isEmpty || productname!.isEmpty || appType!.isEmpty ){
            let alert = UIAlertController(
                        title: "Invalid Log",
                        message: "Please Enter Required Information",
                        preferredStyle: UIAlertController.Style.alert)

            let OKAction = UIAlertAction(title: "Okay", style: .default) { (action) in
                        // do something when user press OK button, like deleting text in both fields or do nothing
                    }

                    alert.addAction(OKAction)
            
            self.requiredfieldimage1.isHidden = false
            self.requiredfieldimage2.isHidden = false
            self.requiredfieldimage3.isHidden = false

            self.present(alert, animated: true, completion: nil)
            
            
        } else {
            
            log.saveInBackground{ (success, error) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                    print("saved!")
                    
                } else {
                    print("error!")
                }
                
            }
        }
        
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
