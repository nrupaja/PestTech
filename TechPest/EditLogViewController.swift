//
//  EditLogViewController.swift
//  PestTech
//
//  Created by Monica Barrios on 12/11/22.
//

import UIKit
import Parse

class EditLogViewController: UIViewController {

    @IBOutlet weak var LocationLabel: UITextField!
    

    @IBOutlet weak var monthLabel: UITextField!
    
    @IBOutlet weak var DayLabel: UITextField!
    
    @IBOutlet weak var YearLabel: UITextField!
    
    
    @IBOutlet weak var ApplicationLabel: UITextField!
    
    
    @IBOutlet weak var CommodityLabel: UITextField!
    
    
    @IBOutlet weak var PesticideLabel: UITextField!
    
    
    @IBOutlet weak var EPALabel: UITextField!
    
    
    @IBOutlet weak var TotalProductUsedLabel: UITextField!
    
    
    @IBOutlet weak var RateLabel: UITextField!
    
    @IBOutlet weak var DilutionLabel: UITextField!
    
    
    @IBOutlet weak var UpdateButton: UIButton!
    
    @IBOutlet weak var DeleteButton: UIButton!
    
    
    @IBAction func UpdateButton(_ sender: Any) {
        log["location"] = LocationLabel.text!
        log["author"] = PFUser.current()!
        //user["author"] = "Test"
//        var saveString = month.text! + " " + dayField.text! + " " + yearField.text!
//        log["date"] = saveString
        log["application"] = ApplicationLabel.text!
        log["commondity"] = CommodityLabel.text!
//        log["treated"] = areaField.text!
        log["pesticide"] = PesticideLabel.text!
        log["epanumber"] = EPALabel.text!
        log["measureunit"] = TotalProductUsedLabel.text!
        log["rateunit"] = RateLabel.text!
        log["dilution"] = DilutionLabel.text!

        let productname = PesticideLabel.text!
        let appType = ApplicationLabel.text!
        let date = monthLabel.text! + DayLabel.text! + YearLabel.text!
        
        if(productname.isEmpty || appType.isEmpty ){
            let alert = UIAlertController(
                        title: "Invalid Log",
                        message: "Please Enter Required Information",
                        preferredStyle: UIAlertController.Style.alert)

            let OKAction = UIAlertAction(title: "Okay", style: .default) { (action) in
                        // do something when user press OK button, like deleting text in both fields or do nothing
                    }

                    alert.addAction(OKAction)
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
    
    @IBAction func DeleteButton(_ sender: Any) {
        log.deleteInBackground()
        self.dismiss(animated: true, completion: nil)

    }
    
    var objectid: String!
    var logs = [PFObject]()
    var log: PFObject!

    override func viewDidLoad() {
        
        super.viewDidLoad()
//        var location = (log["pesticide"] as? String)
//        var month = (log["pesticide"] as? String)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print(objectid)
        var query = PFQuery(className:"Pesticide")
        
        query.includeKeys(["objectId", "application", "location","pesticide","date",""])
        query.getObjectInBackground(withId: objectid ){ ( object , error) ->
            Void in
            
            self.log = object
            
            let datestring = (object!["date"] as! String).split(separator: " ")
            let month = String(datestring[0])
            let day = String(datestring[1])
            let year = String(datestring[2])
            if object != nil && error == nil {
                print((object!["pesticide"] as! String))
                self.PesticideLabel.text = (object!["pesticide"] as! String)
                self.LocationLabel.text = (object!["location"] as! String )
                self.monthLabel.text = month
                self.DayLabel.text = day
                self.YearLabel.text = year
                self.ApplicationLabel.text = (object!["application"] as! String)
                //                self.EPALabel.text = (object![""] as! String)
                self.DilutionLabel.text = (object!["dilution"] as! String)
                self.CommodityLabel.text = (object!["commondity"] as! String)
                self.RateLabel.text = (object!["rateunit"] as! String)
                
            }
            else {
                print(error)
            }
        }
    }
}

