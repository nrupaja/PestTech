//
//  WeatherViewController.swift
//  PestTech
//
//  Created by Nrupaja Vartak on 12/15/22.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import Parse

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    
    @IBOutlet weak var WeatherTableWeather: UITableView!
    
    var weathers = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeatherTableWeather.delegate = self
        WeatherTableWeather.dataSource = self
        
        AF.request("https://api.openweathermap.org/data/2.5/weather?lat=36.65&lon=-121.79&appid=286946a768dd555e633d00e4721f7880&units=imperial").responseJSON {
            response in
            
            let json = JSON(response.value)
            print (json)
            
            let location = json["name"].string
            let description = json["weather"][0]["description"].string
            
            self.locationLabel.text = location
            self.descriptionLabel.text = description
            
            let temp = json["main"]["temp"].float
            let roundedTemp = Int(round(temp ?? 50))
            print(roundedTemp)
            self.temperatureLabel.text = ("\(roundedTemp)")
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "E, MMM d"
            let exactlyCurrentTime: Date = Date()
            self.dateLabel.text = "\(dateFormatterPrint.string(from: exactlyCurrentTime))"
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell") as! WeatherTableViewCell
         
//        let weather = weathers[indexPath.row]
        
//        let dateFormatterPrint = DateFormatter()
//        dateFormatterPrint.dateFormat = "EEEE"
//        let exactlyCurrentDay: Date = Date()
//        cell.dayLabel.text = "\(dateFormatterPrint.string(from: exactlyCurrentDay))"
    
//        let temp = weather["main"]["temp"].float
//        let roundedTemp = Int(round(temp ?? 50))
//        print(roundedTemp)
//        cell.tempLabel.text = ("\(roundedTemp)")
                
        return cell
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

