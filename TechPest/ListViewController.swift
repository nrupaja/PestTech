//
//  ListViewController.swift
//  TechPest
//
//  Created by Monica Barrios on 12/6/22.
//

import UIKit
import Parse
import AlamofireImage
import CoreLocation

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate  {
 
    @IBOutlet weak var LogsTableView: UITableView!
    
    @IBOutlet weak var WelcomeLabel: UILabel!
    
    let myRefreshControl = UIRefreshControl()
    
    let floatingButton: UIButton = {
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        
        //corner radius cirlce
        button.layer.cornerRadius = 30
    
        //color and shadow
        button.backgroundColor =  UIColor(red: 109/255 , green: 173/255, blue: 110/255 , alpha: 0.75)
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.4
        
        return button
        
    }()
    
    var logs = [PFObject]()
    var selectedLog: PFObject!
    //Location
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LogsTableView.delegate = self
        LogsTableView.dataSource = self
        
        floatingButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        view.addSubview(floatingButton)
        
        let user = PFUser.current()
        
        WelcomeLabel.text = "Welcome " + (user?.username)!
        
//        LogsTableView.refreshControl = myRefreshControl
        
        self.LogsTableView.reloadData()

    }
    
    //Location
    func setupLocation(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingHeading()
            requestWeatherforLocation()
        }
    }
    
    func requestWeatherforLocation() {
        guard let currentLocation = currentLocation else {
            return
        }
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        
        print("HERE THEY ARE: \(lat) | \(long)")
        
    }
    
    @objc func didTapButton(){
        self.performSegue(withIdentifier: "NewLogSegue", sender: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x:view.frame.size.width - 70, y: view.frame.size.height - 175, width: 60, height: 60)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.LogsTableView.reloadData()

        var query = PFQuery(className:"Pesticide")
        
        query.includeKeys(["objectId","author", "application", "location","pesticide","date"])
        let user = PFUser.current()
        
        query.order(byDescending:"createdAt")
        query = query.whereKey("author", equalTo: user!)

        query.limit = 20
        
        query.findObjectsInBackground{ (logs , error) in
            if logs != nil {
                self.logs = logs!
                self.LogsTableView.reloadData()
            }
        }
        
        //Location
        setupLocation()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logs.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let log = logs[indexPath.section]
    
        selectedLog = log
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let log = logs[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "LogsListCell") as! LogsListCell
            
        cell.PesticideTitleLabel.text = (log["pesticide"] as? String)
        
        let dateString = (log["date"] as! String)
            
        cell.DateLabel.text = dateString.replacingOccurrences(of: " ", with: "/")

        cell.AreaOfApplicationLabel.text = (log["application"] as? String)
        
   
        if((log["weather"] as! String) == "Rainy"){
            cell.weatherImage.image = UIImage(systemName: "cloud.rain.fill")
        }
        else if(log["weather"] as! String == "Sunny"){
            cell.weatherImage.image = UIImage(systemName: "sun.max.fill")
        }
        else if(log["weather"] as! String == "Cloudy"){
            cell.weatherImage.image = UIImage(systemName: "cloud.sun.fill")
        }
        else if(log["weather"] as! String == "ThunderStorm"){
            cell.weatherImage.image = UIImage(systemName: "cloud.bolt.rain.fill")
        }
        else if(log["weather"] as! String == "Windy"){
           cell.weatherImage.image = UIImage(systemName: "wind")
        }
        else if(log["weather"] as! String == "Freezing"){
            cell.weatherImage.image = UIImage(systemName: "snow")
        }

        return cell
            
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        
        PFUser.logOut()
            
        let main = UIStoryboard(name: "Main", bundle: nil)
            
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
            
        guard let windowScene =  UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
                    
        delegate.window?.rootViewController = loginViewController
    }
    
    override func prepare( for segue: UIStoryboardSegue, sender: Any? ){
        
        if segue.identifier == "EditLogSegue" {

            let cell = sender as! UITableViewCell
            let indexPath = self.LogsTableView.indexPath(for: cell)!
            let selectedLog = logs[indexPath.row]
            let objectId = selectedLog.objectId
            print(objectId)
            let editlogviewcontroller = segue.destination as!EditLogViewController

            editlogviewcontroller.objectid = (objectId)
            LogsTableView.deselectRow(at: indexPath , animated: true)
            if let indexPath = self.LogsTableView.indexPathForSelectedRow {
                let row = Int(indexPath.row)
                editlogviewcontroller.log = selectedLog
            }
        }
        print("Loading up details screen")
    }
}
